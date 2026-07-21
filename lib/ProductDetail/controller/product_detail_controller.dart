import 'package:get/get.dart';
import 'package:project/model/productModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailController extends GetxController {
  bool isLoading = false;
  final supabase = Supabase.instance.client;
  ProductModel? productModelSingle;

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
}
