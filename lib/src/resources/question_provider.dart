import 'dart:async';
import 'dart:convert';
import '../models/question.dart';

class QuestionProvider {
  final questionsJson = '{"questions": [{"id": 1, "docNumber": 1, "label": "Question1", "response": "Réponse1", "category": "DPG" },{"id": 2, "docNumber": 2, "label": "Question2", "response": "Réponse2", "category": "DPS" },{"id": 3, "docNumber": 3, "label": "Question3", "response": "Réponse3", "category": "DPG" },{"id": 4, "docNumber": 4, "label": "Question4", "response": "Réponse4", "category": "DPS" },{"id": 5, "docNumber": 5, "label": "Question5", "response": "Réponse5", "category": "PP"}]}';

  Future<List<Question>> fetchQuestionList() async {
    if (questionsJson.isNotEmpty) {
      // ignore: avoid_print
      print("test");
      Iterable l = json.decode(questionsJson)['questions'];
      List<Question> questions = List<Question>.from(l.map((model) => Question.fromJson(model)));
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }

  Future<Question> fetchQuestionById(int id) async {
    if (questionsJson.isNotEmpty) {
      List<Question> list = json.decode(questionsJson)['questions'];
      Question question = list.singleWhere((q) => q.id == id);
      return question;
    } else {
      throw Exception('Failed to load question ' + id.toString());
    }
  }
}
