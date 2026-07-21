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
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(darkGrey),
                  dividerThickness: 2,

                  // Jarak antar kolom diperkecil
                  columnSpacing: 16,

                  // Margin kiri-kanan table diperkecil
                  horizontalMargin: 8,

                  columns: columns,
                  rows: rows,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
