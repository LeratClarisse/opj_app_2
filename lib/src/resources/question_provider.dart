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
  final questionsJson = '{"questions": [{"id": 1, "docNumber": 1, "label": "Question1", "response": "Réponse1", "category": "DPG" },{"id": 2, "docNumber": 2, "label": "Question2", "response": "Réponse2", "category": "DPS" },{"id": 3, "docNumber": 3, "label": "Question3", "response": "Réponse3", "category": "DPG" },{"id": 4, "docNumber": 4, "label": "Question4", "response": "Réponse4", "category": "DPS" },{"id": 5, "docNumber": 5, "label": "Question5", "response": "Réponse5", "category": "PP"}]}';

  Future<Database> init() async {
    io.Directory applicationDirectory = await getApplicationDocumentsDirectory();

    String dbPath = path.join(applicationDirectory.path, "opj_db.db");

    bool dbExists = await io.File(dbPath).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(path.join("assets", "opj_db.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(dbPath);
  }

  Future<int> fetchNbQuestions() async {
    if (!kIsWeb) {
      Database db = await init();
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
      Database db = await init();
      // Query the table for all The Questions
      final List<Map<String, dynamic>> maps = await db.query('Question', where: "id=?", whereArgs: [
        id
      ]);
      return maps.isNotEmpty ? Question.fromJson(maps.first) : throw Exception('Question ' + id.toString() + ' not found');
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
