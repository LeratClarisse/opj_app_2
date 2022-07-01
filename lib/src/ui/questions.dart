import 'package:flutter/material.dart';
import 'menu.dart';

class Questions extends StatelessWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OPJ Expert'),
      ),
      drawer: const Menu(),
      body: const Center(child: Text("Page Question")),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Précédent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Réponse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Fiche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Suivant',
          ),
        ],
        selectedItemColor: Colors.cyan,
      ),
    );
  }
}
