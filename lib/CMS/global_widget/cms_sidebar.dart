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
        width: 240,
        margin: const EdgeInsets.all(10),
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

      headerBuilder: (_, __) {
        return Padding(
          padding: const EdgeInsets.all(20),

          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.blue,
                child: Text("R", style: TextStyle(color: Colors.white)),
              ),

              SizedBox(width: 12),

              Expanded(
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
        SidebarXItem(icon: Icons.dashboard, label: "Radiators & Coolers"),

        SidebarXItem(icon: Icons.shopping_bag, label: "Radiator Cap & Adapter"),

        SidebarXItem(
          icon: Icons.category,
          label: "CATERPILLAR® Core Replacement",
        ),

        SidebarXItem(
          icon: Icons.person,
          label: "CATERPILLAR® Tube & Shell Oil Cooler",
        ),
      ],
    );
  }
}
