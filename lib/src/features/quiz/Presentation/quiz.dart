import 'package:flutter/material.dart';

import '../../../core/Presentation/menu.dart';
import '../../../core/styles/styles.dart';
import '../Domain/question_entity.dart';
import 'blocs/question_bloc.dart';
import 'choose_quiz.dart';
import 'widgets/quiz_response.dart';
import 'widgets/quiz_response_dps.dart';

class Quiz extends StatefulWidget {
  final String category;
  final String subcategory;
  final String course;
  final String month;

  const Quiz(this.course, this.category, this.subcategory, this.month, {Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _Quiz();
}

class _Quiz extends State<Quiz> {
  bool firstQuestion = true;
  bool selected = false;
  bool dontshow = false;
  double opacityLevel = 0.0;
  final prefixStyle = const TextStyle(fontWeight: FontWeight.bold);

  @override
  void initState() {
    bloc.fetchAllQuestions(widget.course, widget.category, widget.subcategory, widget.month);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ChooseQuiz()),
          );
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Quiz'),
            ),
            drawer: const Menu(),
            body: StreamBuilder(
                stream: bloc.randomQuestion,
                builder: (context, AsyncSnapshot<QuestionEntity?> snapshot) {
                  if (snapshot.hasData) {
                    dontshow = snapshot.data!.dontshow;
                    firstQuestion = bloc.isFirst;
                    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      buildQuestion(context, snapshot.data!.label),
                      if (snapshot.data!.category == 'DPS' && snapshot.data!.answer == null)
                        QuizResponseDPS(opacityLevel: opacityLevel, selected: selected, context: context, question: snapshot.data!)
                      else
                        QuizResponse(
                            opacityLevel: opacityLevel,
                            selected: selected,
                            context: context,
                            response: snapshot.data!.answer!.replaceAll(r'\n', '\n'),
                            id: snapshot.data!.id),
                      const SizedBox(height: 30),
                      buildBottom(context, snapshot.data!.file)
                    ]);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Center(
                        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      const Text("Fin des questions"),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const ChooseQuiz()),
                          );
                        },
                        child: const Text('Recommencer'),
                      ),
                    ]));
                  }
                })));
  }

  Widget buildQuestion(BuildContext context, String question) {
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
            child: Center(child: Text(question, textAlign: TextAlign.center)),
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

  /// Bottom side rendering (buttons)
  Widget buildBottom(BuildContext context, String docName) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ElevatedButton(
              style: elebtn_100x50,
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
                    icon: Icon(firstQuestion ? null : Icons.arrow_left),
                    onPressed: () {
                      if (!firstQuestion) {
                        bloc.fetchPreviousQuestion();
                        setState(() {
                          selected = false;
                          dontshow = false;
                        });
                      }
                    })),
            Expanded(
                child: IconButton(
                    icon: Icon(dontshow ? Icons.visibility_off : Icons.visibility_off_outlined),
                    onPressed: () {
                      dontshow ? bloc.addQuestion() : bloc.removeQuestion();
                      setState(() {
                        dontshow = !dontshow;
                      });
                    })),
            Expanded(
                child: IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      bloc.fetchNextQuestion();
                      setState(() {
                        selected = false;
                        dontshow = false;
                        firstQuestion = false;
                      });
                    }))
          ]),
          const SizedBox(height: 30),
        ]));
  }
}
