import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';

class CustomProductTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;

  const CustomProductTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(darkGrey),
            dividerThickness: 2,
            columns: columns,
            rows: rows,
          ),
        ),
      ),
    );
  }
}
