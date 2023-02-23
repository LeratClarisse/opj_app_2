import 'package:flutter/material.dart';
import '../../features/infractions/Presentation/search_dps.dart';
import '../../features/quiz/Presentation/choose_quiz.dart';
import '../styles/styles.dart';
import 'menu.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              style: elebtn_200x70,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ChooseQuiz()),
                );
              },
              child: const Text('Quiz'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: elebtn_200x70,
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
