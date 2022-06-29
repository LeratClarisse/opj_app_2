import 'package:flutter/material.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: const Text('OPJ Expert'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              style: style,
              onPressed: () {},
              child: const Text('Cours'),
            ),
            ElevatedButton(
              style: style,
              onPressed: () {},
              child: const Text('Récap'),
            ),
            ElevatedButton(
              style: style,
              onPressed: () {},
              child: const Text('Questions'),
            ),
          ],
        ),
      ),
    );
  }
}
