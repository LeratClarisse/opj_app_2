import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import 'package:opjapp/src/core/utils/db_tools.dart';
import 'infraction_dto.dart';

class InfractionDataSource {
  Future<List<InfractionDTO>> fetchAllInfractions() async {
    if (!kIsWeb) {
      Database db = await DbTools.initDB();
      final List<Map<String, dynamic>> maps;

      maps = await db.query('Question', where: 'Category = ?', whereArgs: ['DPS']);

      List<InfractionDTO> infractions = List.generate(maps.length, (i) {
        return InfractionDTO.fromJson(maps[i]);
      });

      DbTools.deleteDB();

      return infractions;
    } else {
      final infractionsJson = await rootBundle.loadString('assets/db/questions.json');

      if (infractionsJson.isNotEmpty) {
        Iterable l = json.decode(infractionsJson)['questions'];
        List<InfractionDTO> infractions = List<InfractionDTO>.from(l.map((model) => InfractionDTO.fromJson(model)));

        infractions = infractions.where((q) => q.category == 'DPS').toList();

        return infractions;
      } else {
        throw Exception('Failed to load infractions');
      }
    }
  }
}
