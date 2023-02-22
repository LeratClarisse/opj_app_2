import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../../core/Data/DTO/question_dto.dart';

class InfractionJsonDataSource {
  Future<List<QuestionDTO>> fetchAllInfractions() async {
    final infractionsJson = await rootBundle.loadString('assets/db/questions.json');

    if (infractionsJson.isNotEmpty) {
      Iterable l = json.decode(infractionsJson)['questions'];
      List<QuestionDTO> infractions = List<QuestionDTO>.from(l.map((model) => QuestionDTO.fromJson(model)));

      infractions = infractions.where((q) => q.category == 'DPS').toList();

      return infractions;
    } else {
      throw Exception('Failed to load infractions');
    }
  }
}
