import 'package:flutter/foundation.dart';
import 'package:opjapp/src/features/infractions/Data/infraction_dto.dart';

import '../Domain/infraction_entity.dart';
import 'infraction_json_datasource.dart';
import 'infraction_sqlite_datasource.dart';

class InfractionRepository {
  late var infractionDS;

  List<InfractionEntity> fetchAllInfractions() {
    if (kIsWeb) {
      infractionDS = InfractionJsonDataSource();
    } else {
      infractionDS = InfractionSqliteDataSource();
    }

    List<InfractionDTO> infractionsBrut = infractionDS.fetchAllInfractions() as List<InfractionDTO>;

    return _convertDatasToEntities(infractionsBrut);
  }

  List<InfractionEntity> _convertDatasToEntities(List<InfractionDTO> infractionsBrut) {
    List<InfractionEntity> infEntities = [];

    for (InfractionDTO inf in infractionsBrut) {
      InfractionEntity infEnt = InfractionEntity(inf.label, inf.dpsLongLabel, inf.dpsArticle, inf.dpsPunissable, inf.dpsIntention, inf.dpsElemMat, inf.dpsDesc);

      infEntities.add(infEnt);
    }

    return infEntities;
  }
}
