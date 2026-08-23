import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/blog/model/blog_model.dart';
import 'package:project/global%20widget/globalLoadingWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;

class BlogController extends GetxController {
  QuillController quillController = QuillController.basic();
  Uint8List? bytes;
  String? imageName;
  final ImagePicker picker = ImagePicker();
  String? imageUrl;
  final SupabaseClient supabase = Supabase.instance.client;
  String type = 'Company News';
  final Dio dio = Dio();
  List<BlogModel> blogs = [];
  List<BlogModel> top3Blogs = [];

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

    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes!, filename: imageName!),
      });

      final response = await dio.post(
        'https://api.indocool.co.id/api/upload',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final path = response.data['path'];

        print('Upload image success: $path');
        imageUrl = 'https://api.indocool.co.id/storage/$path';

        update();

        return imageUrl;
      }

      return null;
    } catch (e) {
      print('Upload image error: $e');
      return null;
    }
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
      print('Error get blog by id: $e');
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

      if (imageUrl == null) {
        print('Gambar gagal diupload');
        return false;
      }

      await supabase.from('blogs').insert({
        'title': title,
        'image_url': imageUrl,
        'content': content,
        'author_id': supabase.auth.currentUser!.id,
        'writer': writer,
        'type': type,
      });

      hideLoadingDialog();
      return true;
    } catch (e) {
      print('Create blog error: $e');
      hideLoadingDialog();
      return false;
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

  Future<void> getTopBlogs({String? excludeId}) async {
    try {
      var query = supabase.from('blogs').select();

      if (excludeId != null) {
        query = query.neq('id', excludeId);
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
