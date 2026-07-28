import 'package:get/get.dart';
import 'package:project/model/productModel.dart';
import 'package:project/theme/string.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailController extends GetxController {
  bool isLoading = false;
  final supabase = Supabase.instance.client;
  ProductModel? productModelSingle;
  List<ProductModel> productModel = [];

  Future<void> getProductById(int id) async {
    try {
      isLoading = true;
      update();

      final response = await supabase
          .from('products')
          .select()
          .eq('id', id)
          .single();

      productModelSingle = ProductModel.fromJson(response);
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to get product: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> sendEmail(ProductModel? product) async {
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
      'https://mail.google.com/mail/?view=cm&fs=1&to=sales@indocool.co.id&su=$subject&body=$body',
    );

    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> getSimilarData({
    required String? categoryData,
    ProductModel? productModelData,
  }) async {
    var response;
    if (categoryData == AppString().radiatorAndCoolers) {
      response = await supabase
          .from('products')
          .select()
          .eq('category_products', categoryData ?? '')
          .eq('makes', productModelData?.makes ?? '')
          .eq('models', productModelData?.models ?? '');
    } else {
      response = await supabase
          .from('products')
          .select()
          .eq('category_products', categoryData ?? '')
          .eq('makes', productModelData?.makes ?? '');
    }

    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }
}
