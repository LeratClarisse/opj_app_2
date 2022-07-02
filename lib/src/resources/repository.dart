import 'dart:async';
import 'document_provider.dart';
import 'question_provider.dart';
import '../models/document.dart';
import '../models/question.dart';

class Repository {
  final documentProvider = DocumentProvider();
  final questionProvider = QuestionProvider();

  Future<List<Document>> fetchAllCourses() => documentProvider.fetchCourseList();
  Future<List<Document>> fetchAllSumUps() => documentProvider.fetchSumUpList();

  Future<List<Question>> fetchAllQuestions() => questionProvider.fetchQuestionList();
  Future<Question> fetchQuestionById(int id) => questionProvider.fetchQuestionById(id);
}
