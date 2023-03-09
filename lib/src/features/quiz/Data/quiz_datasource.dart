import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/Data/DTO/question_dto.dart';

class QuestionDataSource {
  Future<List<QuestionDTO>> fetchAllQuestions(String course, String category, String subcategory, String month) async {
    Box boxQuestions = await Hive.openBox('questions');
    List<QuestionDTO> questions = [];

    if (!boxQuestions.containsKey('questionDTOs')) {
      if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(QuestionDTOAdapter());
      final questionsJson = await rootBundle.loadString('assets/db/questions.json');

      questions = List<QuestionDTO>.from(json.decode(questionsJson)['questions'].map((model) => QuestionDTO.fromJson(model)));

      boxQuestions.put('questionDTOs', questions);
    }

    questions = boxQuestions.get('questionDTOs');

    if (questions.isNotEmpty) {
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
    }

    return questions;
  }
}
