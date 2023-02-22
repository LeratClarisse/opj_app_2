import 'package:rxdart/rxdart.dart';

import '../../Domain/question_entity.dart';
import '../../Domain/question_usecase.dart';

class QuestionsBloc {
  final _usecase = QuestionUsecase();
  final _randomQuestionFetcher = PublishSubject<QuestionEntity?>();
  final _allQuestionsFetcher = PublishSubject<List<QuestionEntity>>();

  Stream<List<QuestionEntity>> get allQuestions => _allQuestionsFetcher.stream;
  Stream<QuestionEntity?> get randomQuestion => _randomQuestionFetcher.stream;
  bool get isFirst => _usecase.isFirst();

  fetchAllQuestions(String course, String category, String subcategory, String month) async {
    _allQuestionsFetcher.sink.add([]);
    _allQuestionsFetcher.sink.add(await _usecase.fetchAllQuestions(course, category, subcategory, month));

    _randomQuestionFetcher.sink.add(_usecase.fetchRandomQuestion());
  }

  fetchPreviousQuestion() async {
    _randomQuestionFetcher.sink.add(_usecase.fetchPreviousQuestion());
  }

  fetchNextQuestion() async {
    _randomQuestionFetcher.sink.add(_usecase.fetchNextQuestion());
  }

  addQuestion() async {
    _usecase.addQuestion();
  }

  removeQuestion() async {
    _usecase.removeQuestion();
  }

  dispose() {
    _randomQuestionFetcher.close();
    _allQuestionsFetcher.close();
  }
}

final bloc = QuestionsBloc();
