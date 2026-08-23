import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:project/theme/theme.dart';

class QuillFieldData extends StatelessWidget {
  final String textName;
  final QuillController controller;

  const QuillFieldData({
    super.key,
    required this.textName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(textName, style: blackTextStyle),
            ),
          ),

          const SizedBox(width: 16),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuillSimpleToolbar(
                    controller: controller,
                    config: const QuillSimpleToolbarConfig(
                      showFontFamily: false,
                      showFontSize: false,
                      showColorButton: false,
                      showBackgroundColorButton: false,
                      showCodeBlock: false,
                      showQuote: false,
                      showSubscript: false,
                      showSuperscript: false,
                    ),
                  ),

                  const Divider(height: 1, color: Colors.grey),

                  SizedBox(
                    height: 300,
                    child: QuillEditor.basic(
                      controller: controller,
                      config: const QuillEditorConfig(
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
