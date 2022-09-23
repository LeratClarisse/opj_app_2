import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:opjapp/src/blocs/question_bloc.dart';
import 'package:opjapp/src/models/question.dart';
import 'package:opjapp/src/ui/choose_questions.dart';
import 'package:opjapp/src/ui/menu.dart';

class Questions extends StatefulWidget {
  final String category;
  final String subcategory;
  final String course;
  final String month;

  const Questions(this.course, this.category, this.subcategory, this.month, {Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _Questions();
}

class _Questions extends State<Questions> {
  bool firstQuestion = true;
  bool selected = false;
  bool dontshow = false;
  double opacityLevel = 0.0;
  final prefixStyle = const TextStyle(fontWeight: FontWeight.bold);
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    fixedSize: const Size(100, 50),
    padding: const EdgeInsets.all(0),
  );

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
            MaterialPageRoute(builder: (context) => const ChooseQuestion()),
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
                builder: (context, AsyncSnapshot<Question?> snapshot) {
                  if (snapshot.hasData) {
                    dontshow = snapshot.data!.dontshow;
                    firstQuestion = bloc.isFirst;
                    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      buildQuestion(context, snapshot.data!.label),
                      if (snapshot.data!.category == 'DPS' && snapshot.data!.answer == null)
                        buildReponseDPS(context, snapshot.data!)
                      else
                        buildReponse(context, snapshot.data!.answer!, snapshot.data!.id),
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
                            MaterialPageRoute(builder: (context) => const ChooseQuestion()),
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

  Widget buildReponse(BuildContext context, String response, int id) {
    response = response.replaceAll(r'\n', '\n');
    return AnimatedOpacity(
        key: ObjectKey(id),
        opacity: opacityLevel,
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          width: selected ? 300 : 0,
          height: selected ? 250 : 0,
          child: Center(child: SingleChildScrollView(scrollDirection: Axis.vertical, child: Text(response + "\n(${id.toString()})"))),
        ));
  }

  Widget buildReponseDPS(BuildContext context, Question question) {
    return AnimatedOpacity(
        key: ObjectKey(question.id),
        opacity: opacityLevel,
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          width: selected ? 300 : 0,
          height: selected ? 250 : 0,
          child: Center(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(question.dpsLongLabel ?? ''),
                const SizedBox(height: 10),
                Text(question.dpsArticle ?? ''),
                const SizedBox(height: 10),
                Text(question.dpsIntention ?? ''),
                const SizedBox(height: 10),
                Text('Tentative: ' + question.dpsPunissable!),
                const SizedBox(height: 10),
                if (question.dpsElemMat != null) buildExpandable('Elément matériel', question.dpsElemMat!),
                const SizedBox(height: 10),
                if (question.dpsDesc != null) buildExpandable('Description', question.dpsDesc!),
              ],
            ),
          )),
        ));
  }

  Widget buildExpandable(String prefixText, String text) {
    return ExpandableText(text.replaceAll(r'\n', '\n'),
        expandText: 'Voir plus',
        collapseText: 'Voir moins',
        animation: true,
        collapseOnTextTap: true,
        prefixText: prefixText + '\n',
        prefixStyle: prefixStyle,
        maxLines: 1,
        linkColor: Colors.lightBlue);
  }

  /// Bottom side rendering (buttons)
  Widget buildBottom(BuildContext context, String docName) {
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
