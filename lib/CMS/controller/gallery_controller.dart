import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/global%20widget/globalLoadingWidget.dart';

import 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;

class CMSGalleryController extends GetxController {
  Uint8List? bytes;
  String? imageName;
  final ImagePicker picker = ImagePicker();
  String? imageUrl;
  final SupabaseClient supabase = Supabase.instance.client;
  String type = 'Company News';
  final Dio dio = Dio();

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

  Future<bool> uploadImageToSupabase({
    required String title,
    required String subtitle,
  }) async {
    showLoadingDialog();

    try {
      imageUrl = await uploadImage();

      if (imageUrl == null) {
        print('Gambar gagal diupload');
        return false;
      }

      await supabase.from('gallery').insert({
        'title': title,
        'image_url': imageUrl,
        'sub_title': subtitle,
      });

      hideLoadingDialog();
      return true;
    } catch (e) {
      print('Create blog error: $e');
      hideLoadingDialog();
      return false;
    }
  }
}
