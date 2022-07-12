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
      '{"questions": [{"id": 1, "file": 1, "label": "Question1", "answer": "Réponse1", "category": "DPG" },{"id": 2, "file": 2, "label": "Question2", "answer": "Réponse2", "category": "DPS" },{"id": 3, "file": 3, "label": "Question3", "answer": "Réponse3", "category": "DPG" },{"id": 4, "file": 4, "label": "Question4", "answer": "Réponse4", "category": "DPS" },{"id": 5, "file": 5, "label": "Question5", "answer": "Réponse5", "category": "PP"}]}';

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

  Future<List<Question>> fetchAllQuestions() async {
    if (!kIsWeb) {
      Database db = await init();
      final List<Map<String, dynamic>> maps = await db.query('Question');
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
