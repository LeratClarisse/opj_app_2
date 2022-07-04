import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../models/question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class QuestionProvider {
  final questionsJson = '{"questions": [{"id": 1, "docNumber": 1, "label": "Question1", "response": "Réponse1", "category": "DPG" },{"id": 2, "docNumber": 2, "label": "Question2", "response": "Réponse2", "category": "DPS" },{"id": 3, "docNumber": 3, "label": "Question3", "response": "Réponse3", "category": "DPG" },{"id": 4, "docNumber": 4, "label": "Question4", "response": "Réponse4", "category": "DPS" },{"id": 5, "docNumber": 5, "label": "Question5", "response": "Réponse5", "category": "PP"}]}';
  final database = openDatabase(
    join('../../../assets/db', 'opj_db.db'),
  );

  Future<int> fetchNbQuestions() async {
    bool test = await File('../../../assets/db/opj_db.db').existsSync();
    //ignore: avoid_print
    print(test);
    if (!kIsWeb) {
      Database db = await database;
      // Convert the List<Map<String, dynamic> into a List<Question>
      int? nb = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Question'));
      // Return COUNT or 0
      return nb ??= 0;
    } else {
      if (questionsJson.isNotEmpty) {
        Iterable l = json.decode(questionsJson)['questions'];
        return l.length;
      } else {
        throw Exception('Failed to load questions');
      }
    }
  }

  Future<Question> fetchQuestionById(int id) async {
    if (!kIsWeb) {
      Database db = await database;
      // Query the table for all The Questions
      final List<Map<String, dynamic>> maps = await db.query('question',
          where: "id = ?",
          whereArgs: [
            id
          ],
          limit: 1);
      return Question.fromJson(maps[0]);
    } else {
      if (questionsJson.isNotEmpty) {
        Iterable l = json.decode(questionsJson)['questions'];
        List<Question> questions = List<Question>.from(l.map((model) => Question.fromJson(model)));
        return questions.singleWhere((q) => q.id == id);
      } else {
        throw Exception('Failed to load question ' + id.toString());
      }
    }
  }
}
