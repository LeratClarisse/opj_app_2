import 'package:flutter/material.dart';
import 'menu.dart';

class Questions extends StatelessWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      fixedSize: const Size(200, 50),
      padding: const EdgeInsets.all(20),
    );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('OPJ Expert'),
        ),
        drawer: const Menu(),
        body: Align(
            alignment: Alignment.bottomCenter,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ElevatedButton(style: style, onPressed: () {}, child: const Text('Réponse')),
              const SizedBox(height: 30),
              Row(children: <Widget>[
                Expanded(child: IconButton(icon: const Icon(Icons.arrow_left), tooltip: 'Préc.', onPressed: () {})),
                Expanded(child: ElevatedButton(style: style, onPressed: () {}, child: const Text('Fiche'))),
                Expanded(child: IconButton(icon: const Icon(Icons.arrow_right), tooltip: 'Suiv.', onPressed: () {}))
              ]),
              const SizedBox(height: 30),
            ])));
  }
}
