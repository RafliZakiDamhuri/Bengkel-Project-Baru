import 'package:get/get.dart';
import 'package:project/global%20widget/globalScaffold.dart';
import 'package:project/model/inquiryType.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalController extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> insertUser({
    required String name,
    required String email,
    required String companyName,
    required String message,
    String? position,
    String? phoneNumber,
    String? inquiryType,
  }) async {
    print('Nama ::: $name');
    try {
      await supabase.from('UserData').insert({
        'name': name,
        'email': email,
        'companyName': companyName,
        'message': message,
        'position': position,
        'phone_number': phoneNumber,
        'inquiry_type_id': inquiryType,
      });
      showSuccessDialog('Sukses', 'Datamu Berhasil Tersimpan', 'Tutup');
      update();
    } catch (e) {
      showSuccessDialog(
        'Gagal',
        'Terjadi Kesalahan Sistem',
        'Coba Lagi :::: $e',
      );
    }
  }

  Future<void> openUrl(String urlString) async {
    final url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch URL';
    }
  }

  Future<void> openWhatsApp(String phone, String message) async {
    final url = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("App sudah load!");
  }
}
