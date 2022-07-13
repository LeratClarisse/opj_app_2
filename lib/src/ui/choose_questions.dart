import 'package:flutter/material.dart';
import 'package:opjapp/src/ui/questions.dart';
import 'menu.dart';

class ChooseQuestion extends StatefulWidget {
  const ChooseQuestion({Key? key}) : super(key: key);
  @override
  State<ChooseQuestion> createState() => _ChooseQuestion();
}

class _ChooseQuestion extends State<ChooseQuestion> {
  String categoryValue = 'Tous';
  String subcategoryValue = 'Tous';

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
            DropdownButton<String>(
              value: categoryValue,
              onChanged: (String? newValue) {
                setState(() {
                  categoryValue = newValue!;
                  if (categoryValue != 'DPG') {
                    subcategoryValue = 'Tous';
                  }
                });
              },
              items: <String>['Tous', 'DPG', 'PP']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            categoryValue == 'DPG'
                ? DropdownButton<String>(
                    value: subcategoryValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        subcategoryValue = newValue!;
                      });
                    },
                    items: <String>['Tous', 'La peine', 'L\'Infraction']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                : const SizedBox(height: 30),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          Questions(categoryValue, subcategoryValue)),
                );
              },
              child: const Text('Commencer'),
            ),
          ],
        ),
      ),
    );
  }
}
