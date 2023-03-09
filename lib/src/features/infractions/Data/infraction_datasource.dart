import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/Data/DTO/question_dto.dart';

class InfractionDataSource {
  Future<List<QuestionDTO>> fetchAllInfractions() async {
    Box boxQuestions = await Hive.openBox('questions');
    List<QuestionDTO> questions = [];

    if (!boxQuestions.containsKey('questionDTOs')) {
      if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(QuestionDTOAdapter());
      final infractionsJson = await rootBundle.loadString('assets/db/questions.json');

      questions = List<QuestionDTO>.from(json.decode(infractionsJson)['questions'].map((model) => QuestionDTO.fromJson(model)));

      boxQuestions.put('questionDTOs', questions);
    }

    questions = boxQuestions.get('questionDTOs');

    return questions.where((q) => q.category == 'DPS').toList();
  }
}
