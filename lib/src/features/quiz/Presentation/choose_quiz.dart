import 'package:flutter/material.dart';
import 'package:opjapp/src/core/styles/buttons.dart';

import '../../../core/Presentation/home.dart';
import '../../../core/Presentation/menu.dart';
import '../../../core/utils/const_lists.dart';
import 'quiz.dart';

class ChooseQuiz extends StatefulWidget {
  const ChooseQuiz({Key? key}) : super(key: key);
  @override
  State<ChooseQuiz> createState() => _ChooseQuiz();
}

class _ChooseQuiz extends State<ChooseQuiz> {
  String categoryValue = 'Toutes';
  String subcategoryValue = 'Toutes';
  String courseValue = 'Tous';
  String monthValue = 'Tous';

  final textStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final textDdlStyle = const TextStyle(fontSize: 18);
  final courseDdlStyle = const TextStyle(
    fontSize: 15,
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
                  Padding(padding: const EdgeInsets.all(20), child: Text("Cours :", style: textStyle)),
                  DropdownButton<String>(
                    value: courseValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        courseValue = newValue!;
                      });
                    },
                    items: listcourseValues.keys.toList().map((key) {
                      return DropdownMenuItem<String>(
                        value: key,
                        child: SizedBox(width: 200.0, child: Text(listcourseValues[key] ?? '', style: courseDdlStyle)),
                      );
                    }).toList(),
                  )
                ]),
                const SizedBox(height: 30),
                courseValue == 'Tous'
                    ? Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        Padding(padding: const EdgeInsets.all(20), child: Text("Mois :", style: textStyle)),
                        DropdownButton<String>(
                          value: monthValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              monthValue = newValue!;
                            });
                          },
                          items: listmonthValues.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: textDdlStyle),
                            );
                          }).toList(),
                        )
                      ])
                    : const SizedBox(height: 30),
                const SizedBox(height: 30),
                courseValue == 'Tous'
                    ? Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                      ])
                    : const SizedBox(height: 30),
                const SizedBox(height: 30),
                categoryValue == 'DPG' && courseValue == 'Tous'
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
                  style: elebtn_200x70,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Quiz(courseValue, categoryValue, subcategoryValue, monthValue)),
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
