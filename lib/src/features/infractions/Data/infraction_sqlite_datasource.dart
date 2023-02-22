import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'package:opjapp/src/core/utils/db_tools.dart';
import 'infraction_dto.dart';

class InfractionSqliteDataSource {
  Future<List<InfractionDTO>> fetchAllInfractions() async {
    Database db = await DbTools.initDB();
    final List<Map<String, dynamic>> maps;

    maps = await db.query('Question', where: 'Category = ?', whereArgs: ['DPS']);

    List<InfractionDTO> infractions = List.generate(maps.length, (i) {
      return InfractionDTO.fromJson(maps[i]);
    });

    DbTools.deleteDB();

    return infractions;
  }
}
