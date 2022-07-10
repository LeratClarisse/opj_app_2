import 'package:flutter/material.dart';
import 'menu.dart';
import '../models/question.dart';
import '../blocs/question_bloc.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _Questions();
}

class _Questions extends State<Questions> {
  bool selected = false;
  double opacityLevel = 0.0;

  @override
  void initState() {
    bloc.fetchRandomQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('OPJ Expert'),
        ),
        drawer: const Menu(),
        body: StreamBuilder(
            stream: bloc.randomQuestion,
            builder: (context, AsyncSnapshot<Question> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      buildQuestion(context, snapshot.data?.label),
                      buildReponse(context, snapshot.data?.answer),
                      const SizedBox(height: 30),
                      buildBottom(context, snapshot.data?.file)
                    ]);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Center(child: Text("Aucune question"));
              }
            }));
  }

  Widget buildQuestion(BuildContext context, String? question) {
    return Expanded(
        child: Stack(alignment: Alignment.center, children: <Widget>[
      AnimatedPositioned(
        width: 200.0,
        height: selected ? 70.0 : 200.0,
        top: selected ? 50.0 : 200.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        child: GestureDetector(
          child: Container(
            color: Colors.blue,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
                child: Text(question ??= "Pas de libellé",
                    textAlign: TextAlign.center)),
          ),
        ),
        onEnd: () {
          setState(() {
            opacityLevel = (opacityLevel - 1.0).abs();
          });
        },
      )
    ]));
  }

  Widget buildReponse(BuildContext context, String? response) {
    if (response != null) {
      response = response.replaceAll(r'\n', '\n');
    }
    return AnimatedOpacity(
      opacity: opacityLevel,
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
          width: selected ? 300 : 0,
          height: selected ? 300 : 0,
          child: Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(response ??= "Pas de libellé")),
          )),
    );
  }

  /// Bottom side rendering (buttons)
  Widget buildBottom(BuildContext context, String? docName) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      fixedSize: const Size(100, 50),
      padding: const EdgeInsets.all(0),
    );

    return Align(
        alignment: Alignment.bottomCenter,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ElevatedButton(
              style: style,
              onPressed: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: selected ? const Text('Cacher') : const Text('Réponse')),
          const SizedBox(height: 30),
          Row(children: <Widget>[
            Expanded(
                child: IconButton(
                    icon: const Icon(Icons.arrow_left),
                    onPressed: () {
                      bloc.fetchRandomQuestion();
                      setState(() {
                        selected = false;
                      });
                    })),
            Expanded(
                flex: 2,
                child: IconButton(
                    icon: const Icon(Icons.document_scanner_outlined),
                    onPressed: () {
                      if (docName != null) {
                        bloc.getDocumentByName(docName);
                      }
                    })),
            Expanded(
                child: IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      bloc.fetchRandomQuestion();
                      setState(() {
                        selected = false;
                      });
                    }))
          ]),
          const SizedBox(height: 30),
        ]));
  }
}
