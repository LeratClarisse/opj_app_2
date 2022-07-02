import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/question.dart';
import 'dart:math';

class QuestionsBloc {
  final _repository = Repository();
  int _nbQuestions = 0;
  final _questionsFetcher = PublishSubject<List<Question>>();
  final _randomQuestionFetcher = PublishSubject<Question>();

  Stream<List<Question>> get allQuestions => _questionsFetcher.stream;
  Stream<Question> get randomQuestion => _randomQuestionFetcher.stream;

  fetchAllQuestions() async {
    List<Question> questions = await _repository.fetchAllQuestions();
    // ignore: avoid_print
    print("test");
    _nbQuestions = questions.length;
    _questionsFetcher.sink.add(questions);
  }

  fetchRandomQuestion() async {
    int randomId = 1 + Random().nextInt(_nbQuestions - 1);
    Question question = await _repository.fetchQuestionById(randomId);
    _randomQuestionFetcher.sink.add(question);
  }

  dispose() {
    _questionsFetcher.close();
    _randomQuestionFetcher.close();
  }
}

final bloc = QuestionsBloc();
