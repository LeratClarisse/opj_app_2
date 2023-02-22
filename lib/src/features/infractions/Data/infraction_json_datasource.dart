import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'infraction_dto.dart';

class InfractionJsonDataSource {
  Future<List<InfractionDTO>> fetchAllInfractions() async {
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
