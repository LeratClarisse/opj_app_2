import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/question.dart';
import 'dart:math';

class QuestionsBloc {
  int _nbQuestions = 0;
  List<Question> _questions = [];
  Question? _currentQuestion;
  final _repository = Repository();
  final _randomQuestionFetcher = PublishSubject<Question>();

  Stream<Question> get randomQuestion => _randomQuestionFetcher.stream;

  fetchAllQuestions() async {
    _questions = await _repository.fetchAllQuestions();
    _nbQuestions = _questions.length;
    fetchRandomQuestion();
  }

  fetchRandomQuestion() async {
    if (_nbQuestions > 0) {
      int randomInt = 0;
      do {
        randomInt = Random().nextInt(_nbQuestions);
      } while (_currentQuestion != null && randomInt == _currentQuestion!.id);

      Question currentQuestion = _questions[randomInt];
      _currentQuestion = currentQuestion;
      _randomQuestionFetcher.sink.add(currentQuestion);
    }
  }

  getDocumentByName(String name) async {
    await _repository.getDocumentByName(name);
  }

  addQuestion() async {
    _questions.add(_currentQuestion!);
    _nbQuestions++;
  }

  removeQuestion() async {
    bool success = _questions.remove(_currentQuestion);
    if (success) {
      _nbQuestions--;
    } else {
      throw "Error removing the question";
    }
  }

  dispose() {
    _randomQuestionFetcher.close();
  }
}

final bloc = QuestionsBloc();
