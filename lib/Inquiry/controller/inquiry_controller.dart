import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:project/Inquiry/model/inquiry_model.dart';
import 'package:project/global%20widget/globalLoadingWidget.dart';
import 'package:project/model/inquiryType.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;
import 'package:universal_html/universal_html.dart' as html;

class InquiryController extends GetxController {
  final supabase = Supabase.instance.client;
  List<InquiryTypeModel> inquiryTypeModel = [];
  String? selectedInquiryType;
  Uint8List? bytes;
  String? fileName;
  String? fileUrl;
  String? fileExtention;
  final Dio dio = Dio();
  List<UserDataModel> userDataModel = [];
  Future getAllInquiryType() async {
    final response = await supabase.from('InquiryType').select();
    print('Ini adalah response get inquiryType ::: $response');
    inquiryTypeModel = response
        .map((e) => InquiryTypeModel.fromJson(e))
        .toList();

    update();
  }

  void setSelectedInquiryType(String? value) {
    selectedInquiryType = value;
  }

  Future<void> pickAndUploadFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'mp4',
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'ppt',
        'pptx',
        'zip',
        'rar',
        'jpg',
        'jpeg',
        'png',
        'webp',
      ],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    if (file.bytes == null) return;

    bytes = file.bytes;
    fileName = file.name;
    fileExtention = file.name.split('.').last.toLowerCase();
    update();
  }

  Future<String?> uploadFile() async {
    if (bytes == null || fileName == null) {
      return null;
    }

    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes!, filename: fileName!),
      });

      final response = await dio.post(
        'https://api.indocool.co.id/api/upload',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final path = response.data['path'];

        fileUrl = 'https://api.indocool.co.id/storage/$path';

        update();

        return fileUrl;
      }

      return null;
    } catch (e) {
      print('Upload file error: $e');
      return null;
    }
  }

  Future<void> uploadResourcesToSupabase({
    String? name,
    String? companyName,
    String? position,
    String? location,
    String? email,
    String? phoneNumber,

    String? description,
  }) async {
    showLoadingDialog();

    try {
      if (fileName != null || fileName != '') {
        fileUrl = await uploadFile();

        if (fileUrl == null) {
          hideLoadingDialog();

          return;
        }
      }

      await supabase.from('UserData').insert({
        'name': name,
        'email': email,
        'description': description,
        'message': fileExtention,
        'position': position,
        'phone_number': phoneNumber,
        'inquiry_type': selectedInquiryType,
        'attachment_url': fileUrl,
        'companyName': companyName,
        'location': location,
      });

      hideLoadingDialog();
      Get.snackbar(
        "Submit Berhasil",
        'Submit Kamu Berhasil',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      hideLoadingDialog();
      print(e);
      Get.snackbar(
        "Submit gagal",
        'Terjadi Kesalahan, Mohon Ulangi Proses Submit  : ${e}',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> downloadFile({required String url, String? fileName}) async {
    try {
      final anchor = html.AnchorElement(href: url)
        ..target = '_blank'
        ..download = fileName ?? 'download';

      html.document.body?.append(anchor);

      anchor.click();

      anchor.remove();
    } catch (e) {}
  }

  Future<void> getUserData() async {
    try {
      showLoadingDialog();
      final response = await supabase
          .from('UserData')
          .select()
          .order('created_at', ascending: false);

      userDataModel = (response as List)
          .map((json) => UserDataModel.fromJson(json))
          .toList();
      update();
      hideLoadingDialog();
    } catch (e) {
      print('Ini adalah error : $e');
      hideLoadingDialog();
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getUserData();
  }
}
