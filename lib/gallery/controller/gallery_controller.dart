import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GalleryController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  Map<String, List<Map<String, dynamic>>> groupedGallery = {};

  bool isLoading = false;

  Future<void> fetchFilteredGallery() async {
    try {
      isLoading = true;
      update();

      final response = await supabase
          .from('gallery')
          .select()
          .order('sub_title', ascending: true)
          .order('title', ascending: true)
          .order('created_at', ascending: true);

      final galleries = List<Map<String, dynamic>>.from(response);

      final Map<String, List<Map<String, dynamic>>> grouped = {};

      for (final item in galleries) {
        final createdAt = DateTime.parse(item['created_at'].toString());

        final subTitle = item['sub_title']?.toString() ?? '';
        final title = item['title']?.toString() ?? '';

        // Group berdasarkan:
        // subtitle + title + tanggal
        final key =
            '$subTitle|$title|'
            '${createdAt.year}-'
            '${createdAt.month.toString().padLeft(2, '0')}-'
            '${createdAt.day.toString().padLeft(2, '0')}';

        grouped.putIfAbsent(key, () => []);

        // Setiap image tetap menjadi object sendiri
        grouped[key]!.add(item);
      }

      groupedGallery = grouped;
    } catch (e) {
      // Error fetching gallery, keep existing data
    } finally {
      isLoading = false;
      update();
    }
  }
}
