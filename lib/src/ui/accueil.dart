import 'package:flutter/material.dart';
import 'cours.dart';
import 'recap.dart';
import 'question.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      fixedSize: const Size(200, 50),
      padding: const EdgeInsets.all(20),
    );

    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: const Text('OPJ Expert'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cours()),
                );
              },
              child: const Text('Cours'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Recap()),
                );
              },
              child: const Text('Récap'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Question()),
                );
              },
              child: const Text('Questions'),
            ),
          ],
        ),
      ),
    );
  }
}
