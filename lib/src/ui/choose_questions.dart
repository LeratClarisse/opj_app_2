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
  String courseValue = 'Tous';
  String monthValue = 'Tous';
  final Map<String, String> listcourseValues = {
    'Tous': 'Tous',
    'F62_03': 'Action civile',
    'F62_02': 'Action publique',
    'F62_40': 'Cadres généraux d\'enquête',
    'F62_41': 'Cadres particuliers d\'enquête',
    'F23_41': 'Destructions, dégradations et détériorations',
    'F61_08': 'Définition et classification des peines',
    'F23_34': 'Escroquerie',
    'F23_00': 'Étude du droit pénal spécial',
    'F23_33': 'Extorsion et chantage',
    'F62_42': 'Information au PR, transport, constatations et réquisitions',
    'F23_35': 'Infractions voisines de l\'escroquerie',
    'F61_02': 'L\'infraction',
    'F61_03': 'La classification des infractions',
    'F62_01': 'La faute civile et la faute pénale',
    'F61_04': 'La tentative punissable',
    'F62_04': 'Le ministère public',
    'F62_10': 'Les APJ et les APJA',
    'F62_16': 'Les juridictions d\'instruction',
    'F62_09': 'Officiers de police judiciaire',
    'F62_45': 'Perquisitions et saisies',
    'F62_08': 'Police judiciaire',
    'F62_24': 'Preuve en matière répressive',
    'F61_01': 'Présentation du droit pénal',
    'F23_40': 'Recel et infractions voisines',
    'F23_60': 'Usurpation ou usage irrégulier de fonctions, nom ou qualité',
    'F23_32': 'Vol'
  };

  final textStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final textDdlStyle = const TextStyle(fontSize: 18);
  final courseDdlStyle = const TextStyle(
    fontSize: 15,
  );
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
                          items: <String>['Tous', 'Juillet / Août', 'Septembre', 'Octobre'].map<DropdownMenuItem<String>>((String value) {
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
                  style: styleButton,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Questions(courseValue, categoryValue, subcategoryValue, monthValue)),
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
