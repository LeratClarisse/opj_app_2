import 'package:flutter/widgets.dart';

class QuizResponse extends StatelessWidget {
  const QuizResponse({
    Key? key,
    required this.opacityLevel,
    required this.selected,
    required this.context,
    required this.response,
    required this.id,
  }) : super(key: key);

  final double opacityLevel;
  final bool selected;
  final BuildContext context;
  final String response;
  final int id;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        key: ObjectKey(id),
        opacity: opacityLevel,
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          width: selected ? 300 : 0,
          height: selected ? 250 : 0,
          child: Center(child: SingleChildScrollView(scrollDirection: Axis.vertical, child: Text("$response\n(${id.toString()})"))),
        ));
  }
}
