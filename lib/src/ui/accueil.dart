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
            OutlinedButton(
              style: style,
              onPressed: () {},
              child: const Text('Cours'),
            ),
            const SizedBox(height: 30),
            TextButton(
              style: style,
              onPressed: () {},
              child: const Text('Récap'),
            ),
            const SizedBox(height: 30),
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
