import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GalleryController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> gallery = [];

  bool isLoading = false;

  List<String> topics = [];
  List<String> products = [];

  String? selectedTopic;
  String? selectedProduct;

  Future<void> fetchFilterOptions() async {
    try {
      final response = await supabase
          .from('gallery')
          .select('title, sub_title');

      final data = List<Map<String, dynamic>>.from(response);

      final topicOptions =
          data
              .map((item) => item['title']?.toString() ?? '')
              .where((value) => value.isNotEmpty)
              .toSet()
              .toList()
            ..sort();

      final productOptions =
          data
              .map((item) => item['sub_title']?.toString() ?? '')
              .where((value) => value.isNotEmpty)
              .toSet()
              .toList()
            ..sort();

      topics = topicOptions;
      products = productOptions;
      update();
    } catch (e) {
      // Error fetching filter options, keep existing options
    }
  }

  Future<void> fetchFilteredGallery() async {
    try {
      isLoading = true;
      update();

      var query = supabase.from('gallery').select();

      if (selectedTopic != null) {
        query = query.eq('title', selectedTopic!);
      }

      if (selectedProduct != null) {
        query = query.eq('sub_title', selectedProduct!);
      }

      final response = await query.order('created_at', ascending: true);

      gallery = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      // Error fetching gallery, keep existing data
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> setTopic(String? value) async {
    selectedTopic = value;
    await fetchFilteredGallery();
  }

  Future<void> setProduct(String? value) async {
    selectedProduct = value;
    await fetchFilteredGallery();
  }
}
