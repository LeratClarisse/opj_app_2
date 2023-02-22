import 'package:flutter/foundation.dart';

import '../../../core/Data/DTO/question_dto.dart';
import '../Domain/infraction_entity.dart';
import 'infraction_json_datasource.dart';
import 'infraction_sqlite_datasource.dart';

class InfractionRepository {
  // ignore: prefer_typing_uninitialized_variables
  late var infractionDS;

  Future<List<InfractionEntity>> fetchAllInfractions() async {
    if (kIsWeb) {
      infractionDS = InfractionJsonDataSource();
    } else {
      infractionDS = InfractionSqliteDataSource();
    }

    List<QuestionDTO> infractionsBrut = await infractionDS.fetchAllInfractions() as List<QuestionDTO>;

    return _convertDatasToEntities(infractionsBrut);
  }

  List<InfractionEntity> _convertDatasToEntities(List<QuestionDTO> infractionsBrut) {
    List<InfractionEntity> infEntities = [];

    for (QuestionDTO inf in infractionsBrut) {
      InfractionEntity infEnt =
          InfractionEntity(inf.label, inf.dpsLongLabel, inf.dpsArticle, inf.dpsPunissable, inf.dpsIntention, inf.dpsElemMat, inf.dpsDesc);

      infEntities.add(infEnt);
    }

    return infEntities;
  }
}
