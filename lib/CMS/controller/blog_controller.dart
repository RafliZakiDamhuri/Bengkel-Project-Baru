import 'dart:typed_data';

import 'package:flutter/services.dart' show TextSelection;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/blog/model/blog_model.dart';
import 'package:project/core/services/upload_service.dart';
import 'package:project/global_widget/globalErrorBottomSheet.dart';
import 'package:project/global_widget/globalLoadingWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;

class BlogController extends GetxController {
  QuillController quillController = QuillController.basic();
  Uint8List? bytes;
  String? imageName;
  final ImagePicker picker = ImagePicker();
  String? imageUrl;
  final SupabaseClient supabase = Supabase.instance.client;
  String type = 'Company News';
  final UploadService _uploadService = UploadService();
  List<BlogModel> blogs = [];
  List<BlogModel> top3Blogs = [];

  void resetForm() {
    bytes = null;
    imageName = null;
    imageUrl = null;
    type = 'Company News';
    blog = null;
    quillController.document = Document();
    quillController.updateSelection(
      const TextSelection.collapsed(offset: 0),
      ChangeSource.local,
    );
    update();
  }

  BlogModel? blog;
  int? selectedMonth;
  int? selectedYear;
  String? selectedContent;
  Future<void> setMonth(String? value) async {
    const months = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12,
    };

    selectedMonth = months[value];

    await getBlogsbyFilter(
      month: selectedMonth,
      year: selectedYear,
      contentType: selectedContent,
    );
  }

  Future<void> setYear(String? value) async {
    selectedYear = value == null ? null : int.tryParse(value);

    await getBlogsbyFilter(
      month: selectedMonth,
      year: selectedYear,
      contentType: selectedContent,
    );
  }

  Future<void> setContentType(String? value) async {
    selectedContent = value;

    await getBlogsbyFilter(
      month: selectedMonth,
      year: selectedYear,
      contentType: selectedContent,
    );
  }

  Future<void> pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    bytes = await image.readAsBytes();
    imageName = image.name;
    update();
  }

  Future<String?> uploadImage() async {
    if (bytes == null || imageName == null) {
      return null;
    }

    final result = await _uploadService.uploadBytes(
      bytes: bytes!,
      filename: imageName!,
    );

    if (result != null) {
      imageUrl = result;
      update();
      return imageUrl;
    }

    return null;
  }

  Future<void> getBlogById(String id) async {
    try {
      final response = await supabase
          .from('blogs')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (response == null) {
        return;
      }

      blog = BlogModel.fromJson(response);
      update();
    } catch (e) {
      // Error suppressed
    }
  }

  Future<void> getBlogByTitle(String title) async {
    try {
      final response = await supabase
          .from('blogs')
          .select()
          .eq('title', title)
          .limit(1)
          .maybeSingle();

      if (response == null) {
        return;
      }

      blog = BlogModel.fromJson(response);
      update();
    } catch (e) {
      // Error suppressed
    }
  }

  Future<void> pickAndInsertImageToQuill() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    showLoadingDialog(); // Tampilkan loading saat proses upload

    try {
      final Uint8List quillImageBytes = await image.readAsBytes();

      // Upload gambar menggunakan service yang sudah Anda buat
      final String? uploadedUrl = await _uploadService.uploadBytes(
        bytes: quillImageBytes,
        filename:
            'quill_${DateTime.now().millisecondsSinceEpoch}_${image.name}', // Nama unik
      );

      hideLoadingDialog();

      if (uploadedUrl != null) {
        // Dapatkan posisi kursor di editor saat ini
        final index = quillController.selection.baseOffset;
        final length = quillController.selection.extentOffset - index;

        // Sisipkan URL gambar publik ke dalam dokumen Quill
        quillController.replaceText(
          index,
          length,
          BlockEmbed.image(uploadedUrl),
          null,
        );

        // Geser kursor ke sebelah kanan gambar agar bisa lanjut mengetik
        quillController.updateSelection(
          TextSelection.collapsed(offset: index + 1),
          ChangeSource.local,
        );
      } else {
        showErrorBottomSheet(Exception('Gagal mengunggah gambar konten.'));
      }
    } catch (e) {
      hideLoadingDialog();
      showErrorBottomSheet(e);
    }
  }

  Future<bool> createBlog({
    required String title,
    required String writer,
  }) async {
    showLoadingDialog();

    try {
      final content = quillController.document.toDelta().toJson();
      imageUrl = await uploadImage();

      if (bytes != null && imageUrl == null) {
        showErrorBottomSheet(Exception('Gagal mengunggah gambar.'));
        return false;
      }

      await supabase.from('blogs').insert({
        'title': title,
        if (imageUrl != null) 'image_url': imageUrl,
        'content': content,
        'author_id': supabase.auth.currentUser!.id,
        'writer': writer,
        'type': type,
      });

      return true;
    } catch (e) {
      showErrorBottomSheet(e);
      return false;
    } finally {
      hideLoadingDialog();
    }
  }

  Future<bool> updateBlog(
    String id, {
    required String title,
    required String writer,
    required List<dynamic> content,
  }) async {
    showLoadingDialog();

    try {
      if (bytes != null && imageName != null) {
        final newUrl = await uploadImage();

        await supabase
            .from('blogs')
            .update({
              'title': title,
              'writer': writer,
              'type': type,
              'content': content,
              'image_url': newUrl,
            })
            .eq('id', id);
      } else {
        await supabase
            .from('blogs')
            .update({
              'title': title,
              'writer': writer,
              'type': type,
              'content': content,
            })
            .eq('id', id);
      }

      hideLoadingDialog();
      await getBlogsbyFilter();
      return true;
    } catch (e) {
      hideLoadingDialog();
      showErrorBottomSheet(e);
      return false;
    } finally {
      hideLoadingDialog();
    }
  }

  Future<bool> deleteBlogById(String id) async {
    try {
      showLoadingDialog();

      final deleted = await supabase
          .from('blogs')
          .delete()
          .eq('id', id)
          .select();

      hideLoadingDialog();

      if (deleted.isEmpty) {
        showErrorBottomSheet(
          Exception('Data gagal dihapus, periksa policy DELETE di Supabase'),
        );
        return false;
      }

      blogs.removeWhere((b) => b.id == id);
      update();
      return true;
    } catch (e) {
      hideLoadingDialog();
      showErrorBottomSheet(e);
      return false;
    } finally {
      hideLoadingDialog();
    }
  }

  Future<void> getBlogsbyFilter({
    int? month,
    int? year,
    String? contentType,
  }) async {
    try {
      final response = await supabase.rpc(
        'get_blogs',
        params: {
          'p_month': month,
          'p_year': year,
          'p_content_type': contentType,
        },
      );

      blogs = List<BlogModel>.from(
        response.map((json) => BlogModel.fromJson(json)),
      );
      update();
    } catch (e) {
      throw Exception('Failed to get blogs: $e');
    }
  }

  Future<void> getTopBlogs({String? excludeTitle}) async {
    try {
      var query = supabase.from('blogs').select();

      if (excludeTitle != null && excludeTitle.isNotEmpty) {
        query = query.neq('title', excludeTitle);
      }

      final response = await query
          .order('created_at', ascending: false)
          .limit(3);

      top3Blogs = List<BlogModel>.from(
        response.map((json) => BlogModel.fromJson(json)),
      );
      update();
    } catch (e) {
      throw Exception('Failed to get top blogs: $e');
    }
  }
}
