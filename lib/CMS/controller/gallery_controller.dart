import 'dart:typed_data';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/core/services/upload_service.dart';
import 'package:project/global_widget/globalLoadingWidget.dart';

import 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;

class CMSGalleryController extends GetxController {
  Uint8List? bytes;
  String? imageName;
  final ImagePicker picker = ImagePicker();
  String? imageUrl;
  final SupabaseClient supabase = Supabase.instance.client;
  String type = 'Company News';
  final UploadService _uploadService = UploadService();

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

  Future<bool> uploadImageToSupabase({
    required String title,
    required String subtitle,
  }) async {
    showLoadingDialog();

    try {
      imageUrl = await uploadImage();

      if (imageUrl == null) {
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
      hideLoadingDialog();
      return false;
    }
  }
}
