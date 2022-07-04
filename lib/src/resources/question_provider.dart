import 'dart:async';
import 'dart:convert';
import '../models/question.dart';

class QuestionProvider {
  final questionsJson = '{"questions": [{"id": 1, "docNumber": 1, "label": "Question1", "response": "Réponse1", "category": "DPG" },{"id": 2, "docNumber": 2, "label": "Question2", "response": "Réponse2", "category": "DPS" },{"id": 3, "docNumber": 3, "label": "Question3", "response": "Réponse3", "category": "DPG" },{"id": 4, "docNumber": 4, "label": "Question4", "response": "Réponse4", "category": "DPS" },{"id": 5, "docNumber": 5, "label": "Question5", "response": "Réponse5", "category": "PP"}]}';

  Future<List<Question>> fetchQuestionList() async {
    // Read all items (journals)
    // static Future<List<Map<String, dynamic>>> getItems() async {
    //   final db = await SQLHelper.db();
    //   return db.query('items', orderBy: "id");
    // }
    if (questionsJson.isNotEmpty) {
      Iterable l = json.decode(questionsJson)['questions'];
      List<Question> questions = List<Question>.from(l.map((model) => Question.fromJson(model)));
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }

  Future<Question> fetchQuestionById(int id, List<Question> list) async {
    // Read a single item by id
    // The app doesn't use this method but I put here in case you want to see it
    // static Future<List<Map<String, dynamic>>> getItem(int id) async {
    //   final db = await SQLHelper.db();
    //   return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
    // }
    if (questionsJson.isNotEmpty) {
      Question question = list.singleWhere((q) => q.id == id);
      return question;
    } else {
      throw Exception('Failed to load question ' + id.toString());
    }
  }
}
