import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/question.dart';
import 'dart:math';

class QuestionsBloc {
  int _nbQuestions = 0;
  int _currentQuestionId = 0;
  List<Question> _questions = [];
  final _repository = Repository();
  final _randomQuestionFetcher = PublishSubject<Question>();

  Stream<Question> get randomQuestion => _randomQuestionFetcher.stream;

  fetchRandomQuestion() async {
    if (_questions == []) {
      _questions = await _repository.fetchAllQuestions();
    }

    _nbQuestions = _questions.length;

    if (_nbQuestions > 0) {
      int randomId = 0;
      do {
        randomId = 1 + Random().nextInt(_nbQuestions - 1);
      } while (randomId == _currentQuestionId);

      Question currentQuestion = await _repository.fetchQuestionById(randomId, _questions);
      _currentQuestionId = currentQuestion.id;
      _randomQuestionFetcher.sink.add(currentQuestion);
    }
  }

  dispose() {
    _randomQuestionFetcher.close();
  }
}

final bloc = QuestionsBloc();
