import 'dart:async';
import '../models/question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuestionProvider {
  final questionsJson = '{"questions": [{"id": 1, "docNumber": 1, "label": "Question1", "response": "Réponse1", "category": "DPG" },{"id": 2, "docNumber": 2, "label": "Question2", "response": "Réponse2", "category": "DPS" },{"id": 3, "docNumber": 3, "label": "Question3", "response": "Réponse3", "category": "DPG" },{"id": 4, "docNumber": 4, "label": "Question4", "response": "Réponse4", "category": "DPS" },{"id": 5, "docNumber": 5, "label": "Question5", "response": "Réponse5", "category": "PP"}]}';
  final database = openDatabase(
    join('../../assets/db', 'opj_db.db'),
  );

  Future<List<Question>> fetchQuestionList() async {
    Database db = await database;

    // Query the table for all The Questions
    final List<Map<String, dynamic>> maps = await db.query('question');

    // Convert the List<Map<String, dynamic> into a List<Question>
    return List.generate(maps.length, (i) {
      return Question.fromJson(maps[i]);
    });
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
