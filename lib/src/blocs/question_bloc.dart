import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/question.dart';
import 'dart:math';

class QuestionsBloc {
  int _nbQuestions = 0;
  List<Question> _questions = [];
  List<Question> _pastQuestions = [];
  Question? _currentQuestion;
  final _repository = Repository();
  final _randomQuestionFetcher = PublishSubject<Question?>();

  Stream<Question?> get randomQuestion => _randomQuestionFetcher.stream;
  bool get isFirst =>
      _pastQuestions.indexWhere((q) => q.id == _currentQuestion!.id) <= 0
          ? true
          : false;

  fetchAllQuestions(String category, String subcategory) async {
    _questions = await _repository.fetchAllQuestions(category, subcategory);
    _nbQuestions = _questions.length;
    _pastQuestions = [];
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
      _pastQuestions.add(_currentQuestion!);
      _questions.remove(_currentQuestion);
      _nbQuestions--;
      _randomQuestionFetcher.sink.add(currentQuestion);
    } else if (_pastQuestions.where((q) => !q.dontshow).isNotEmpty) {
      _questions = _pastQuestions.where((q) => !q.dontshow).toList();
      _nbQuestions = _questions.length;
      _pastQuestions = [];
      fetchRandomQuestion();
    } else {
      _randomQuestionFetcher.sink.add(null);
    }
  }

  fetchPreviousQuestion() async {
    int indexCurrent =
        _pastQuestions.indexWhere((q) => q.id == _currentQuestion!.id);
    _currentQuestion = _pastQuestions[indexCurrent - 1];
    _randomQuestionFetcher.sink.add(_currentQuestion!);
  }

  fetchNextQuestion() async {
    int indexCurrent =
        _pastQuestions.indexWhere((q) => q.id == _currentQuestion!.id);
    if (indexCurrent == _pastQuestions.length - 1) {
      await fetchRandomQuestion();
    } else {
      _currentQuestion = _pastQuestions[indexCurrent + 1];
      _randomQuestionFetcher.sink.add(_currentQuestion!);
    }
  }

  getDocumentByName(String name) async {
    await _repository.getDocumentByName(name);
  }

  addQuestion() async {
    _currentQuestion!.dontshow = false;
    _pastQuestions.singleWhere((q) => q.id == _currentQuestion!.id).dontshow =
        false;
  }

  removeQuestion() async {
    _currentQuestion!.dontshow = true;
    _pastQuestions.singleWhere((q) => q.id == _currentQuestion!.id).dontshow =
        true;
  }

  dispose() {
    _randomQuestionFetcher.close();
  }
}

final bloc = QuestionsBloc();
