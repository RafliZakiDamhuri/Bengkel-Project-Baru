import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/global_widget/cms_sidebar.dart';
import 'package:project/CMS/presentation/add_data.dart';
import 'package:project/CMS/presentation/edit_data.dart';
import 'package:project/CMS/presentation/pre_edit.dart';
import 'package:project/global%20widget/globalAppBar.dart';

class CmsPage extends StatelessWidget {
  CmsPage({super.key});

  final controller = Get.put(CmsController());

  @override
  Widget build(BuildContext context) {
    return Globalappbar(
      isNeedInquiryPage: false,
      pageWidget: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            CmsSidebar(controller: controller.sidebarController),

            Expanded(
              child: AnimatedBuilder(
                animation: controller.sidebarController,

                builder: (context, child) {
                  return IndexedStack(
                    index: controller.sidebarController.selectedIndex,

                    children: const [
                      AddData(titleCategory: "Radiators and Coolers"),
                      AddData(titleCategory: "Radiators and Coolers"),

                      AddData(titleCategory: "Radiator Cap and Adapter"),

                      AddData(
                        titleCategory:
                            "CATERPILLAR® TUBE AND SHELL OIL COOLER SEARCH PART",
                      ),

                      AddData(titleCategory: "CATERPILLAR RADIATOR CORE"),

                      PreEdit(titleCategory: "Radiators and Coolers"),

                      PreEdit(titleCategory: "Radiator Cap and Adapter"),

                      AddData(titleCategory: "Radiators and Coolers"),

                      AddData(titleCategory: "Radiators and Coolers"),

                      AddData(titleCategory: "Radiators and Coolers"),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
