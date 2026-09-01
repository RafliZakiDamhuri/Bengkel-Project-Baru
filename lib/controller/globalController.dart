import 'package:get/get.dart';
import 'package:project/global%20widget/globalScaffold.dart';
import 'package:project/model/inquiryType.dart';
import 'package:project/model/productModel.dart';

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

  Future<void> openLocation() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/place/PT.+Indocool+Solusi+Cemerlang/@-6.5089238,106.8561451,17z/data=!3m1!4b1!4m6!3m5!1s0x2e69c100d2b8b3b9:0x425b9debd07be858!8m2!3d-6.5089238!4d106.8561451!16s%2Fg%2F1pzt985by?entry=ttu&g_ep=EgoyMDI2MDgyNi4wIKXMDSoASAFQAw%3D%3D',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
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

  Future<void> sendEmail({ProductModel? product, String? email}) async {
    final productName =
        product?.productType ?? product?.catalogueNumber ?? 'Product';

    final subject = Uri.encodeComponent(
      'Product Information Request - $productName',
    );

    final body = Uri.encodeComponent('''
Dear INDOCOOL Sales Team,

I would like to request information regarding the following product/service:

Product / Service:
$productName

Company Name:
____________

Contact Person:
____________

Position:
____________

Country:
____________

Phone / WhatsApp:
____________

Quantity Required:
____________

Message / Special Instruction:
____________

Please contact me with further information, pricing, availability, and technical recommendations.

Thank you.

Best Regards
''');

    final gmailUri = Uri.parse(
      'https://mail.google.com/mail/?view=cm&fs=1&to=$email&su=$subject&body=$body',
    );

    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("App sudah load!");
  }
}
