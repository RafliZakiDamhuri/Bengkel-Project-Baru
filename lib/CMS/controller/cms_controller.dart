import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class CmsController extends GetxController {
  late SidebarXController sidebarController;

  @override
  void onInit() {
    super.onInit();

    sidebarController = SidebarXController(selectedIndex: 0, extended: true);
  }

  @override
  void onClose() {
    sidebarController.dispose();
    super.onClose();
  }
}
