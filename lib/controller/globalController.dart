import 'package:get/get.dart';
import 'package:project/global%20widget/globalScaffold.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class GlobalController extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> insertUser({
    required String name,
    required String email,
    required String companyName,
    required String message,
  }) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from('UserData').insert({
        'name': name,
        'email': email,
        'companyName': companyName,
        'message': message,
      });
      showSuccessDialog('Sukses', 'Datamu Berhasil Tersimpan', 'Tutup');
      update();
    } catch (e) {
      showSuccessDialog('Gagal', 'Terjadi Kesalahan Sistem', 'Coba Lagi');
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("App sudah load!");
  }
}
