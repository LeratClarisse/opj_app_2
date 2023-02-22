import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../core/Data/DTO/question_dto.dart';

class QuestionJsonDataSource {
  Future<List<QuestionDTO>> fetchAllQuestions(String course, String category, String subcategory, String month) async {
    final questionsJson = await rootBundle.loadString('assets/db/questions.json');

    if (questionsJson.isNotEmpty) {
      Iterable l = json.decode(questionsJson)['questions'];
      List<QuestionDTO> questions = List<QuestionDTO>.from(l.map((model) => QuestionDTO.fromJson(model)));

      if (course != 'Tous') {
        questions = questions.where((q) => q.file == course).toList();
      } else {
        if (category != 'Toutes') {
          questions = questions.where((q) => q.category == category).toList();
          if (subcategory != 'Toutes') {
            questions = questions.where((q) => q.subcategory == subcategory).toList();
          }
        }
        if (month != 'Tous') {
          questions = questions.where((q) => q.month == month).toList();
        }
      }

      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
