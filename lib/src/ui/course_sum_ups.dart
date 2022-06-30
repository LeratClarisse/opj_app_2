import 'package:flutter/material.dart';
import 'menu.dart';

class CourseSumUps extends StatelessWidget {
  const CourseSumUps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OPJ Expert'),
      ),
      drawer: const Menu(),
      body: const Center(child: Text("Page Récap")),
    );
  }
}
