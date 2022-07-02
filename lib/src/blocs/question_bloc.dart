import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/question.dart';
import 'dart:math';

class QuestionsBloc {
  final _repository = Repository();
  int _nbQuestions = 0;
  List<Question> questions = [];
  final _randomQuestionFetcher = PublishSubject<Question>();

  Stream<Question> get randomQuestion => _randomQuestionFetcher.stream;

  fetchRandomQuestion() async {
    questions = await _repository.fetchAllQuestions();
    _nbQuestions = questions.length;
    if (_nbQuestions == 0 || _nbQuestions == -1) {
      int randomId = 1 + Random().nextInt(_nbQuestions - 1);
      Question question = await _repository.fetchQuestionById(randomId);
      _randomQuestionFetcher.sink.add(question);
    }
  }

  dispose() {
    _randomQuestionFetcher.close();
  }
}

final bloc = QuestionsBloc();
