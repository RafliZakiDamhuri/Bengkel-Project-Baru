import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:project/core/config/app_config.dart';

/// Meng-handle upload file ke REST API Indocool.
///
/// Sebelumnya, logika upload (endpoint + konfigurasi Dio) di-copy paste di
/// beberapa controller (CMS, Blog, Gallery, Resources, Inquiry). Service ini
/// memusatkan logika tersebut agar mudah dipelihara dan konsisten.
class UploadService {
  static const String _baseUrl = AppConfig.apiBaseUrl;
  static const String _uploadEndpoint = '$_baseUrl/api/upload';

  final Dio _dio = Dio();

  /// Upload [bytes] dengan [filename] ke server.
  ///
  /// Mengembalikan URL penuh file yang di-upload (mis.
  /// `https://api.indocool.co.id/storage/<path>`), atau `null` jika gagal.
  Future<String?> uploadBytes({
    required Uint8List bytes,
    required String filename,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes, filename: filename),
      });

      final response = await _dio.post(_uploadEndpoint, data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final path = response.data?['path'];
        if (path == null) return null;
        return '$_baseUrl/storage/$path';
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
