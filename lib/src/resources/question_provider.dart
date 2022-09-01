import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:opjapp/src/models/question.dart';
import 'package:opjapp/src/utils/db_tools.dart';
import 'package:sqflite/sqflite.dart';

class QuestionProvider {
  Future<List<Question>> fetchAllQuestions(String course, String category, String subcategory) async {
    if (!kIsWeb) {
      Database db = await DbTools.initDB();
      final List<Map<String, dynamic>> maps;
      String whereString = '';
      List<Object> whereArgs = [];

      if (course != 'Tous' || category != 'Toutes') {
        if (course != 'Tous') {
          whereString = 'File = ?';
          whereArgs = [course];
        } else if (category != 'Toutes') {
          whereString = 'Category = ?';
          whereArgs = [category];
          if (subcategory != 'Toutes') {
            whereString += ' AND Subcategory = ?';
            whereArgs.add(subcategory);
          }
        }
        maps = await db.query('Question', where: whereString, whereArgs: whereArgs);
      } else {
        maps = await db.query('Question');
      }

      List<Question> questions = List.generate(maps.length, (i) {
        return Question.fromJson(maps[i]);
      });

      // Extract questions as JSON
      // String jsonQuestions = json.encode(questions);

      DbTools.deleteDB();

      return questions;
    } else {
      final questionsJson = await rootBundle.loadString('assets/db/questions.json');

      if (questionsJson.isNotEmpty) {
        Iterable l = json.decode(questionsJson)['questions'];
        List<Question> questions = List<Question>.from(l.map((model) => Question.fromJson(model)));

        if (course != 'Tous') {
          questions = questions.where((q) => q.file == course).toList();
        } else if (category != 'Toutes') {
          questions = questions.where((q) => q.category == category).toList();
          if (subcategory != 'Toutes') {
            questions = questions.where((q) => q.subcategory == subcategory).toList();
          }
        }

        return questions;
      } else {
        throw Exception('Failed to load questions');
      }
    }
  }
}
