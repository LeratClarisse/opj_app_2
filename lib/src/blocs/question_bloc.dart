import 'package:opjapp/src/models/question.dart';
import 'package:opjapp/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

class QuestionsBloc {
  int _nbQuestions = 0;
  List<Question> _questions = [];
  List<Question> _pastQuestions = [];
  Question? _currentQuestion;
  final _repository = Repository();
  final _randomQuestionFetcher = PublishSubject<Question?>();
  final _allQuestionsFetcher = PublishSubject<List<Question>>();

  Stream<List<Question>> get allQuestions => _allQuestionsFetcher.stream;
  Stream<Question?> get randomQuestion => _randomQuestionFetcher.stream;
  bool get isFirst => _pastQuestions.indexWhere((q) => q.id == _currentQuestion!.id) <= 0 ? true : false;

  fetchAllQuestions(String course, String category, String subcategory, String month, {bool fetchRandom = false}) async {
    _questions = await _repository.fetchAllQuestions(course, category, subcategory, month);
    _nbQuestions = _questions.length;
    _pastQuestions = [];

    _allQuestionsFetcher.sink.add([]);
    _allQuestionsFetcher.sink.add(_questions);

    if (fetchRandom) {
      fetchRandomQuestion();
    }
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
    int indexCurrent = _pastQuestions.indexWhere((q) => q.id == _currentQuestion!.id);
    _currentQuestion = _pastQuestions[indexCurrent - 1];
    _randomQuestionFetcher.sink.add(_currentQuestion!);
  }

  fetchNextQuestion() async {
    int indexCurrent = _pastQuestions.indexWhere((q) => q.id == _currentQuestion!.id);
    if (indexCurrent == _pastQuestions.length - 1) {
      await fetchRandomQuestion();
    } else {
      _currentQuestion = _pastQuestions[indexCurrent + 1];
      _randomQuestionFetcher.sink.add(_currentQuestion!);
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
  
  searchDps({String search = ''}) {
    if (search.isEmpty) {
      _allQuestionsFetcher.sink.add([]);
      _allQuestionsFetcher.sink.add(_questions);
    } else {
      _allQuestionsFetcher.sink.add([]);

      List<Question> matchingQuestions = _questions.where((q) => q.dpsLongLabel!.toLowerCase().contains(search.toLowerCase())).toList();
      _allQuestionsFetcher.sink.add(matchingQuestions);
    }
  }

  dispose() {
    _randomQuestionFetcher.close();
    _allQuestionsFetcher.close();
  }
}

final bloc = QuestionsBloc();
