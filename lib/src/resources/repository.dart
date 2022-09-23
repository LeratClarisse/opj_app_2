import 'dart:async';
import 'package:opjapp/src/models/question.dart';
import 'question_provider.dart';

class Repository {
  final questionProvider = QuestionProvider();

  Future<List<Question>> fetchAllQuestions(String course, String category, String subcategory, String month) => questionProvider.fetchAllQuestions(course, category, subcategory, month);
}
