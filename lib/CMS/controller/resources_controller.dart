import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:project/core/services/upload_service.dart';
import 'package:project/global_widget/globalErrorBottomSheet.dart';
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
  String? currentId;

  void resetForm() {
    type = null;
    bytes = null;
    fileName = null;
    fileUrl = null;
    fileExtention = null;
    currentId = null;
    update();
  }

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
      showErrorBottomSheet(e);
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
      showErrorBottomSheet(e);
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
    } catch (e) {
      showErrorBottomSheet(e);
    }
  }

  List<String> fileNames = [];
  List<String> types = [];

  Future<void> getResourceById(String id) async {
    try {
      showLoadingDialog();

      final response = await supabase
          .from('resources')
          .select()
          .eq('id', id)
          .single();

      final resource = ResourceModel.fromJson(response);
      currentId = resource.id;
      type = resource.type;
      fileName = resource.fileName;
      fileUrl = resource.fileUrl;
      fileExtention = resource.fileExtention;
      update();
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
      showErrorBottomSheet(e);
    } finally {
      hideLoadingDialog();
    }
  }

  Future<void> updateResource(String id) async {
    try {
      showLoadingDialog();

      if (bytes != null && fileName != null) {
        final newUrl = await uploadFile();

        await supabase.from('resources').update({
          'file_name': fileName,
          'file_url': newUrl,
          'file_extention': fileExtention,
          'type': type,
        }).eq('id', id);
      } else {
        await supabase.from('resources').update({
          'type': type,
        }).eq('id', id);
      }

      hideLoadingDialog();
      await getResources();
    } catch (e) {
      hideLoadingDialog();
      showErrorBottomSheet(e);
    } finally {
      hideLoadingDialog();
    }
  }

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
      hideLoadingDialog();
      showErrorBottomSheet(e);
    } finally {
      hideLoadingDialog();
    }
  }

  Future<bool> deleteResourceById(String id) async {
    try {
      showLoadingDialog();
      final deleted = await supabase
          .from('resources')
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

      resources.removeWhere((r) => r.id == id);
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
}
