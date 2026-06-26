import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:project/global%20widget/globalScaffold.dart';
import 'package:project/model/mainProductModel.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:universal_html/html.dart' as html;

class MainProductController extends GetxController {
  final supabase = Supabase.instance.client;
  bool isLoading = true;
  List<MainProductModel>? mainProductModel;
  Future getProduct() async {
    mainProductModel = [];
    final response = await supabase.from('MainProduct').select();
    mainProductModel = response
        .map((e) => MainProductModel.fromJson(e))
        .toList();
    isLoading = false;
    update();
  }

  Future<void> downloadPdfMobile(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/file.pdf');

      await file.writeAsBytes(response.bodyBytes);

      print('File saved at: ${file.path}');
    } else {
      throw Exception('Failed to download PDF');
    }
  }

  Future<void> downloadPdfWeb(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final blob = html.Blob([response.bodyBytes]);
      final urlBlob = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: urlBlob)
        ..setAttribute("download", "file.pdf")
        ..click();

      html.Url.revokeObjectUrl(urlBlob);
    } else {
      throw Exception('Failed to download PDF');
    }
  }

  Future<void> downloadPdf(String url) async {
    if (kIsWeb) {
      await downloadPdfWeb(url);
    } else {
      await downloadPdfMobile(url);
    }
  }

  @override
  void onInit() {
    getProduct();
    super.onInit();
  }
}
