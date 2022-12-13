import 'package:flutter/material.dart';
import 'package:opjapp/src/ui/about.dart';
import 'package:opjapp/src/ui/choose_quiz.dart';
import 'package:opjapp/src/ui/home.dart';
import 'package:opjapp/src/ui/search_dps.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 125,
          child: DrawerHeader(
            decoration: BoxDecoration(color: Colors.black, image: DecorationImage(image: AssetImage("assets/icon/logo_opj.png"))),
            child: Text(''),
          ),
        ),
        ListTile(
          title: const Text('Accueil'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
        ListTile(
          title: const Text('Questions'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ChooseQuiz()),
            );
          },
        ),
        ListTile(
          title: const Text('Infractions'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SearchDPS()),
            );
          },
        ),
        ListTile(
          title: const Text('À propos'),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const About()),
            );
          },
        ),
      ],
    ));
  }
}
