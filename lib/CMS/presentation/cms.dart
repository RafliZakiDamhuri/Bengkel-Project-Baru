import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/global_widget/cms_sidebar.dart';
import 'package:project/CMS/presentation/add_data.dart';
import 'package:project/CMS/presentation/edit_data.dart';
import 'package:project/CMS/presentation/pre_edit.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/theme/string.dart';

class CmsPage extends StatelessWidget {
  CmsPage({super.key});

  final controller = Get.put(CmsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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

                    children: [
                      Container(), //0 Register

                      Container(), //1 Add Data

                      AddData(titleCategory: "Radiators and Coolers"), //2
                      AddData(titleCategory: "Radiator Cap and Adapter"), //3
                      AddData(titleCategory: AppString().caterpilarTube), //4
                      AddData(titleCategory: "CATERPILLAR RADIATOR CORE"), //5

                      Container(), //6 Edit Data

                      PreEdit(titleCategory: "Radiators and Coolers"), //7
                      PreEdit(titleCategory: "Radiator Cap and Adapter"), //8
                      PreEdit(titleCategory: AppString().caterpilarTube), //9
                      PreEdit(
                        titleCategory: AppString().caterpillarRadiatorCore,
                      ), //10
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
