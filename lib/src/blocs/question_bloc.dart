import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/question.dart';

class QuestionsBloc {
  final _repository = Repository();
  final _questionsFetcher = PublishSubject<List<Question>>();

  Stream<List<Question>> get allQuestions => _questionsFetcher.stream;

  fetchAllQuestions() async {
    List<Question> questions = await _repository.fetchAllQuestions();
    _questionsFetcher.sink.add(questions);
  }

  dispose() {
    _questionsFetcher.close();
  }
}

final bloc = QuestionsBloc();
