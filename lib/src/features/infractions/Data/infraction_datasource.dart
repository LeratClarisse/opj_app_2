import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/Data/DTO/question_dto.dart';

class InfractionDataSource {
  Future<List<QuestionDTO>> fetchAllInfractions() async {
    Box boxQuestions = await Hive.openBox('questions');

    if (!boxQuestions.containsKey('questionDTOs')) {
      final infractionsJson = await rootBundle.loadString('assets/db/questions.json');
      boxQuestions.put('questionDTOs', json.decode(infractionsJson)['questions']);
    }

    List<QuestionDTO> questions =
        List<QuestionDTO>.from(boxQuestions.get('questionDTOs').map((model) => QuestionDTO.fromJson(model)));

    return questions.where((q) => q.category == 'DPS').toList();
  }
}
