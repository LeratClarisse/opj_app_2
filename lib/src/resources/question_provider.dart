import 'dart:async';
import '../models/question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuestionProvider {
  final database = openDatabase(
    join('../../assets/db', 'opj_db.db'),
  );

  Future<int> fetchNbQuestions() async {
    Database db = await database;

    // Convert the List<Map<String, dynamic> into a List<Question>
    int? nb = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Question'));

    // Return COUNT or 0
    return nb ??= 0;
  }

  Future<Question> fetchQuestionById(int id) async {
    Database db = await database;

    // Query the table for all The Questions
    final List<Map<String, dynamic>> maps = await db.query('question',
        where: "id = ?",
        whereArgs: [
          id
        ],
        limit: 1);

    return Question.fromJson(maps[0]);
  }
}
