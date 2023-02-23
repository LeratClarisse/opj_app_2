import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/styles.dart';

class ExpandableTextWidget extends StatelessWidget {
  const ExpandableTextWidget({Key? key, required this.text, required this.prefixText}) : super(key: key);

  final String text;
  final String prefixText;

  @override
  Widget build(BuildContext context) {
    return ExpandableText(text.replaceAll(r'\n', '\n'),
        expandText: 'Voir plus',
        collapseText: 'Voir moins',
        animation: true,
        collapseOnTextTap: true,
        prefixText: '$prefixText\n',
        prefixStyle: prefixStyle,
        maxLines: 1,
        linkColor: Colors.lightBlue);
  }
}
