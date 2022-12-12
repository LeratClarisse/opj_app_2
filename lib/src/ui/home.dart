import 'package:flutter/material.dart';
import 'package:opjapp/src/ui/choose_questions.dart';
import 'package:opjapp/src/ui/menu.dart';
import 'package:opjapp/src/ui/search_dps.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      fixedSize: const Size(200, 70),
      padding: const EdgeInsets.all(0),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OPJ Expert'),
      ),
      drawer: const Menu(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ChooseQuestion()),
                );
              },
              child: const Text('Quiz'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SearchDPS()),
                );
              },
              child: const Text('Infractions'),
            ),
          ],
        ),
      ),
    );
  }
}
