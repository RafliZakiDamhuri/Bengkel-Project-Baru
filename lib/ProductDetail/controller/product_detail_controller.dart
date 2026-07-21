import 'package:get/get.dart';
import 'package:project/model/productModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  Future<void> getSimilarData({
    required String? categoryData,
    ProductModel? productModelData,
  }) async {
    final response = await supabase
        .from('products')
        .select()
        .eq('category_products', categoryData ?? '')
        .eq('makes', productModelData?.makes ?? '')
        .eq('models', productModelData?.models ?? '');

    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }
}
