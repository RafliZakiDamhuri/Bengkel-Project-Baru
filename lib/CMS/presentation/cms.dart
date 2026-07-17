import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/global_widget/cms_sidebar.dart';

class CmsPage extends StatelessWidget {
  CmsPage({super.key});

  final controller = Get.put(CmsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CmsSidebar(controller: controller.sidebarController),

          Expanded(
            child: AnimatedBuilder(
              animation: controller.sidebarController,

              builder: (context, child) {
                return IndexedStack(
                  index: controller.sidebarController.selectedIndex,

                  children: const [
                    // DashboardPage(),

                    // ProductPage(),

                    // CategoryPage(),
                    Center(child: Text("Product")),

                    Center(child: Text("Category")),

                    Center(child: Text("Profile")),

                    Center(child: Text("Profile")),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
