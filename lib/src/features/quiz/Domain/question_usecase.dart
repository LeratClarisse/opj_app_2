import 'dart:math';

import 'package:opjapp/src/features/quiz/Data/quiz_repository.dart';
import 'package:opjapp/src/features/quiz/Domain/question_entity.dart';

class QuestionUsecase {
  int _nbQuestions = 0;
  List<QuestionEntity> _questions = [];
  List<QuestionEntity> _pastQuestions = [];
  QuestionEntity? _currentQuestion;
  final _repository = QuestionRepository();

  bool get isFirst => _pastQuestions.indexWhere((q) => q.id == _currentQuestion!.id) <= 0 ? true : false;

  fetchAllQuestions(String course, String category, String subcategory, String month) async {
    _questions = _repository.fetchAllQuestions(course, category, subcategory, month);
    _nbQuestions = _questions.length;
    _pastQuestions = [];

    return _questions;
  }

  fetchRandomQuestion() async {
    if (_nbQuestions > 0) {
      int randomInt = 0;
      do {
        randomInt = Random().nextInt(_nbQuestions);
      } while (_currentQuestion != null && randomInt == _currentQuestion!.id);

      QuestionEntity currentQuestion = _questions[randomInt];
      _currentQuestion = currentQuestion;
      _pastQuestions.add(_currentQuestion!);
      _questions.remove(_currentQuestion);
      _nbQuestions--;
      return currentQuestion;
    } else if (_pastQuestions.where((q) => !q.dontshow).isNotEmpty) {
      _questions = _pastQuestions.where((q) => !q.dontshow).toList();
      _nbQuestions = _questions.length;
      _pastQuestions = [];
      fetchRandomQuestion();
    } else {
      return null;
    }
  }

  fetchPreviousQuestion() async {
    int indexCurrent = _pastQuestions.indexWhere((q) => q.id == _currentQuestion!.id);
    _currentQuestion = _pastQuestions[indexCurrent - 1];
    return _currentQuestion!;
  }

  fetchNextQuestion() async {
    int indexCurrent = _pastQuestions.indexWhere((q) => q.id == _currentQuestion!.id);
    if (indexCurrent == _pastQuestions.length - 1) {
      await fetchRandomQuestion();
    } else {
      _currentQuestion = _pastQuestions[indexCurrent + 1];
      return _currentQuestion!;
    }
  }

  addQuestion() async {
    _currentQuestion!.dontshow = false;
    _pastQuestions.singleWhere((q) => q.id == _currentQuestion!.id).dontshow = false;
  }

  removeQuestion() async {
    _currentQuestion!.dontshow = true;
    _pastQuestions.singleWhere((q) => q.id == _currentQuestion!.id).dontshow = true;
  }
}
