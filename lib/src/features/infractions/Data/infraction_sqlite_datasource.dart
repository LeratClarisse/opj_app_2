import 'dart:async';
import 'package:opjapp/src/core/Data/DTO/question_dto.dart';
import 'package:sqflite/sqflite.dart';

import 'package:opjapp/src/core/utils/db_tools.dart';

class InfractionSqliteDataSource {
  Future<List<QuestionDTO>> fetchAllInfractions() async {
    Database db = await DbTools.initDB();
    final List<Map<String, dynamic>> maps;

    maps = await db.query('Question', where: 'Category = ?', whereArgs: ['DPS']);

    List<QuestionDTO> infractions = List.generate(maps.length, (i) {
      return QuestionDTO.fromJson(maps[i]);
    });

    DbTools.deleteDB();

    return infractions;
  }
}
