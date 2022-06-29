import 'package:flutter/material.dart';

class Recap extends StatelessWidget {
  const Recap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OPJ Expert'),
      ),
      body: const Center(child: Text("Page Récap")),
    );
  }
}
