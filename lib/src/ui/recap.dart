import 'package:flutter/material.dart';
import 'cours.dart';
import 'question.dart';
import 'accueil.dart';

class Recap extends StatelessWidget {
  const Recap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OPJ Expert'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Accueil()),
                );
              },
            ),
            ListTile(
              title: const Text('Cours'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Cours()),
                );
              },
            ),
            ListTile(
              title: const Text('Récap'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Recap()),
                );
              },
            ),
            ListTile(
              title: const Text('Questions'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Question()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text("Page Récap")),
    );
  }
}
