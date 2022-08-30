import 'package:flutter/material.dart';
import 'package:opjapp/src/ui/home.dart';
import 'package:opjapp/src/ui/menu.dart';
import 'package:opjapp/src/ui/questions.dart';

class ChooseQuestion extends StatefulWidget {
  const ChooseQuestion({Key? key}) : super(key: key);
  @override
  State<ChooseQuestion> createState() => _ChooseQuestion();
}

class _ChooseQuestion extends State<ChooseQuestion> {
  String categoryValue = 'Toutes';
  String subcategoryValue = 'Toutes';

  final textStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final textDdlStyle = const TextStyle(fontSize: 18);
  final ButtonStyle styleButton = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    fixedSize: const Size(200, 50),
    padding: const EdgeInsets.all(0),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()),
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Choix du sujet'),
          ),
          drawer: const Menu(),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Padding(padding: const EdgeInsets.all(20), child: Text("Catégorie :", style: textStyle)),
                  DropdownButton<String>(
                    value: categoryValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        categoryValue = newValue!;
                      });
                    },
                    items: <String>['Toutes', 'DPG', 'PP', 'DPS'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: textDdlStyle),
                      );
                    }).toList(),
                  )
                ]),
                const SizedBox(height: 30),
                categoryValue == 'DPG'
                    ? Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        Padding(padding: const EdgeInsets.all(20), child: Text("Sous-Catégorie :", style: textStyle)),
                        DropdownButton<String>(
                          value: subcategoryValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              subcategoryValue = newValue!;
                            });
                          },
                          items: <String>['Toutes', 'La peine', 'L\'Infraction'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: textDdlStyle),
                            );
                          }).toList(),
                        )
                      ])
                    : const SizedBox(height: 30),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: styleButton,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Questions(categoryValue, subcategoryValue)),
                    );
                  },
                  child: const Text('Commencer'),
                ),
              ],
            ),
          ),
        ));
  }
}
