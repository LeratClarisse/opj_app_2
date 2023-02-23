import 'dart:async';
import 'package:opjapp/src/core/Data/DTO/question_dto.dart';
import 'package:sqflite/sqflite.dart';

import 'package:opjapp/src/core/utils/db_tools.dart';

class QuestionSqliteDataSource {
  Future<List<QuestionDTO>> fetchAllQuestions(String course, String category, String subcategory, String month) async {
    Database db = await DbTools.initDB();
    final List<Map<String, dynamic>> maps;
    String whereString = '';
    List<Object> whereArgs = [];

    if (course != 'Tous' || category != 'Toutes' || month != 'Tous') {
      if (course != 'Tous') {
        whereString = 'File = ?';
        whereArgs = [course];
      } else {
        if (category != 'Toutes') {
          whereString = 'Category = ?';
          whereArgs = [category];
          if (subcategory != 'Toutes') {
            whereString += ' AND Subcategory = ?';
            whereArgs.add(subcategory);
          }
        }
        if (month != 'Tous') {
          whereString += whereString.isNotEmpty ? ' AND Month = ?' : 'Month = ?';
          whereArgs.add(month);
        }
      }
      maps = await db.query('Question', where: whereString, whereArgs: whereArgs);
    } else {
      maps = await db.query('Question');
    }

    List<QuestionDTO> questions = List.generate(maps.length, (i) {
      return QuestionDTO.fromJson(maps[i]);
    });

    // Extract questions as JSON for web version
    //log(json.encode(questions));

    DbTools.deleteDB();

    return questions;
  }
}
