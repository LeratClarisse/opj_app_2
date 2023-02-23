import 'package:flutter/material.dart';

import '../../Domain/question_entity.dart';
import 'expandable_text.dart';

class QuizResponseDPS extends StatelessWidget {
  const QuizResponseDPS({
    Key? key,
    required this.opacityLevel,
    required this.selected,
    required this.context,
    required this.question,
  }) : super(key: key);

  final double opacityLevel;
  final bool selected;
  final BuildContext context;
  final QuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        key: ObjectKey(question.id),
        opacity: opacityLevel,
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          width: selected ? 300 : 0,
          height: selected ? 250 : 0,
          child: Center(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(question.dpsLongLabel ?? ''),
                const SizedBox(height: 10),
                Text(question.dpsArticle ?? ''),
                const SizedBox(height: 10),
                Text(question.dpsIntention ?? ''),
                const SizedBox(height: 10),
                Text('Tentative: ${question.dpsPunissable!}'),
                const SizedBox(height: 10),
                if (question.dpsElemMat != null) ExpandableTextWidget(text: question.dpsElemMat!, prefixText: 'Elément matériel'),
                const SizedBox(height: 10),
                if (question.dpsDesc != null) ExpandableTextWidget(text: question.dpsDesc!, prefixText: 'Description'),
              ],
            ),
          )),
        ));
  }
}
