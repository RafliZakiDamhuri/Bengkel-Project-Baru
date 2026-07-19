import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class CmsSidebar extends StatelessWidget {
  final SidebarXController controller;

  const CmsSidebar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,

      theme: SidebarXTheme(
        width: 100,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: Colors.grey.shade200)),
        ),
        selectedItemDecoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
        ),

        hoverColor: Colors.grey.shade100,

        itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        itemTextPadding: const EdgeInsets.only(left: 14),
        selectedTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.blue,
        ),
        textStyle: const TextStyle(color: Colors.black87),
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        iconTheme: const IconThemeData(color: Colors.grey),
      ),

      extendedTheme: const SidebarXTheme(width: 240),
      headerBuilder: (_, extended) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              if (extended) ...[
                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "RADMAX",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Content Management",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
              IconButton(
                icon: Icon(
                  extended
                      ? Icons.keyboard_double_arrow_left
                      : Icons.keyboard_double_arrow_right,
                ),
                onPressed: () {
                  controller.setExtended(!extended);
                },
              ),
            ],
          ),
        );
      },
      footerDivider: Divider(),
      footerBuilder: (context, extended) {
        return ListTile(
          leading: Icon(Icons.logout),

          title: Text("Logout"),

          onTap: () {},
        );
      },
      items: const [
        SidebarXItem(icon: Icons.inventory, label: "Add Data"),

        SidebarXItem(icon: Icons.arrow_right, label: "   Radiators & Coolers"),

        SidebarXItem(
          icon: Icons.arrow_right,
          label: "   Radiator Cap & Adapter",
        ),

        SidebarXItem(
          icon: Icons.arrow_right,
          label: "   CATERPILLAR® Core Replacement",
        ),

        SidebarXItem(icon: Icons.inventory, label: "Edit Data"),

        SidebarXItem(icon: Icons.arrow_right, label: "   Radiators & Coolers"),

        SidebarXItem(
          icon: Icons.arrow_right,
          label: "   Radiator Cap & Adapter",
        ),

        SidebarXItem(
          icon: Icons.arrow_right,
          label: "   CATERPILLAR® Core Replacement",
        ),
      ],
    );
  }
}
