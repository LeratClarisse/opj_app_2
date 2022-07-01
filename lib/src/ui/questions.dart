import 'package:flutter/material.dart';
import 'menu.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _Questions();
}

class _Questions extends State<Questions> {
  bool selected = false;
  double opacityLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('OPJ Expert'),
        ),
        drawer: const Menu(),
        body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          buildQuestion(context),
          buildReponse(context),
          buildBottom(context)
        ]));
  }

  Widget buildQuestion(BuildContext context) {
    return Expanded(
        child: Stack(alignment: Alignment.center, children: <Widget>[
      AnimatedPositioned(
        width: selected ? 100.0 : 200.0,
        height: selected ? 100.0 : 200.0,
        top: selected ? 50.0 : 150.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
        child: GestureDetector(
          child: Container(
            color: Colors.blue,
            child: const Center(child: Text('Question')),
          ),
        ),
      )
    ]));
  }

  Widget buildReponse(BuildContext context) {
    return Visibility(
        visible: selected,
        maintainAnimation: true,
        maintainState: true,
        maintainSize: true,
        child: AnimatedOpacity(
          opacity: opacityLevel,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            child: Container(
              color: Colors.blue,
              child: const Center(child: Text('Réponse')),
            ),
          ),
        ));
  }

  /// Bottom side rendering (buttons)
  Widget buildBottom(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      fixedSize: const Size(200, 50),
      padding: const EdgeInsets.all(20),
    );

    return Align(
        alignment: Alignment.bottomCenter,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ElevatedButton(
              style: style,
              onPressed: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: const Text('Réponse')),
          const SizedBox(height: 30),
          Row(children: <Widget>[
            Expanded(child: IconButton(icon: const Icon(Icons.arrow_left), onPressed: () {})),
            Expanded(flex: 2, child: IconButton(icon: const Icon(Icons.document_scanner_outlined), onPressed: () {})),
            Expanded(child: IconButton(icon: const Icon(Icons.arrow_right), onPressed: () {}))
          ]),
          const SizedBox(height: 30),
        ]));
  }
}
