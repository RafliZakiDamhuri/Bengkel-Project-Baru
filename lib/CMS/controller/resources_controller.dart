import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:project/core/services/upload_service.dart';
import 'package:project/global_widget/globalLoadingWidget.dart';
import 'package:project/resources/model/resource_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;
import 'package:universal_html/html.dart' as html;

class ResourcesController extends GetxController {
  String? type;
  Uint8List? bytes;
  String? fileName;
  String? fileUrl;
  String? fileExtention;

  List<ResourceModel> resources = [];
  List<ResourceModel> filteredResources = [];

  final SupabaseClient supabase = Supabase.instance.client;
  final UploadService _uploadService = UploadService();
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

    final result = await _uploadService.uploadBytes(
      bytes: bytes!,
      filename: fileName!,
    );

    if (result != null) {
      fileUrl = result;
      update();
      return fileUrl;
    }

    return null;
  }

  Future<void> uploadResourcesToSupabase() async {
    showLoadingDialog();

    try {
      fileUrl = await uploadFile();

      if (fileUrl == null) {
        hideLoadingDialog();

        return;
      }

      await supabase.from('resources').insert({
        'file_name': fileName,
        'type': type,
        'file_url': fileUrl,
        'file_extention': fileExtention,
      });

      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
    }
  }

  Future<void> getResourcesByType({String? type}) async {
    try {
      showLoadingDialog();

      var query = supabase.from('resources').select();

      if (type != null && type != 'All') {
        query = query.eq('type', type);
      }

      final response = await query.order('created_at', ascending: false);

      resources = List<ResourceModel>.from(
        response.map((json) => ResourceModel.fromJson(json)),
      );
      update();
    } catch (e) {
      hideLoadingDialog();
    } finally {
      hideLoadingDialog();
    }
  }

  Future<void> getDataByFilter(String? queryData, String? type) async {
    final Map<String, String> columnMap = {
      'File Name': 'file_name',
      'Resource Type': 'type',
    };

    final column = columnMap[type];

    var query = supabase.from('resources').select('*');

    if (column != null && queryData != null) {
      query = query.eq(column, queryData);
    }

    final response = await query;

    resources = List<ResourceModel>.from(
      response.map((json) => ResourceModel.fromJson(json)),
    );
    update();
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

  List<String> fileNames = [];
  List<String> types = [];
  Future<void> getResources() async {
    try {
      showLoadingDialog();

      final response = await supabase
          .from('resources')
          .select()
          .order('created_at', ascending: false);

      resources = List<ResourceModel>.from(
        response.map((json) => ResourceModel.fromJson(json)),
      );
      fileNames = resources
          .map((resource) => resource.fileName)
          .whereType<String>()
          .where((value) => value.isNotEmpty)
          .toList();

      // Ambil type secara distinct
      types = resources
          .map((resource) => resource.type)
          .where((value) => value != null && value.isNotEmpty)
          .cast<String>()
          .toSet()
          .toList();
      update();
      hideLoadingDialog();
    } catch (e) {
    } finally {
      hideLoadingDialog();
    }
  }
}
