import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/question.dart';
import 'dart:math';

class QuestionsBloc {
  final _repository = Repository();
  int _nbQuestions = 0;
  List<Question> _questions = [];
  final _randomQuestionFetcher = PublishSubject<Question>();

  Stream<Question> get randomQuestion => _randomQuestionFetcher.stream;

  fetchRandomQuestion() async {
    _questions = await _repository.fetchAllQuestions();
    _nbQuestions = _questions.length;
    if (_nbQuestions > 0) {
      int randomId = 1 + Random().nextInt(_nbQuestions - 1);
      Question question = await _repository.fetchQuestionById(randomId, _questions);
      _randomQuestionFetcher.sink.add(question);
    }
  }

  dispose() {
    _randomQuestionFetcher.close();
  }
}

final bloc = QuestionsBloc();
