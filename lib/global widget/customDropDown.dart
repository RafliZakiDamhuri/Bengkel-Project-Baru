import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';

class CustomDropdown extends StatelessWidget {
  final String hintName;
  final double width;
  final String? value;
  final List<dynamic> items;
  final String Function(dynamic) labelBuilder;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    super.key,
    required this.hintName,
    required this.width,
    required this.value,
    required this.items,
    required this.labelBuilder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          hintText: hintName,
          hintStyle: TextStyle(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.grey[300],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item?.id.toString(),
            child: Text(
              labelBuilder(item),
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
