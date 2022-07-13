import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import '../models/question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class QuestionProvider {
  final questionsJson =
      '{"questions": [{"Id": 1, "File": "1", "Label": "Question1", "Answer": "Réponse1", "Category": "DPG" },{"Id": 2, "File": "2", "Label": "Question2", "Answer": "Réponse2", "Category": "DPS" },{"Id": 3, "File": "3", "Label": "Question3", "Answer": "Réponse3", "Category": "DPG" },{"Id": 4, "File": "4", "Label": "Question4", "Answer": "Réponse4", "Category": "DPS" },{"Id": 5, "File": "5", "Label": "Question5", "Answer": "Réponse5", "Category": "PP"}]}';

  Future<Database> init() async {
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();

    String dbPath = path.join(applicationDirectory.path, "opj_db.db");

    bool dbExists = await io.File(dbPath).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data =
          await rootBundle.load(path.join("assets", "db", "opj_db.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(dbPath);
  }

  Future<List<Question>> fetchAllQuestions(
      String category, String subcategory) async {
    if (!kIsWeb) {
      Database db = await init();
      final List<Map<String, dynamic>> maps;

      if (category != 'Tous') {
        String whereString = 'Category = ?';
        List<Object> whereArgs = [category];
        if (subcategory != 'Tous') {
          whereString += ' AND Subcategory = ?';
          whereArgs.add(subcategory);
        }
        maps = await db.query('Question',
            where: whereString, whereArgs: whereArgs);
      } else {
        maps = await db.query('Question');
      }

      return List.generate(maps.length, (i) {
        return Question.fromJson(maps[i]);
      });
    } else {
      if (questionsJson.isNotEmpty) {
        Iterable l = json.decode(questionsJson)['questions'];
        List<Question> questions =
            List<Question>.from(l.map((model) => Question.fromJson(model)));
        return questions;
      } else {
        throw Exception('Failed to load questions');
      }
    }
  }
}
