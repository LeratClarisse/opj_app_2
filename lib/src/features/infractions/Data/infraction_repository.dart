import 'package:opjapp/src/features/infractions/Data/infraction_dto.dart';

import '../Domain/infraction_entity.dart';
import 'infraction_datasource.dart';

class InfractionRepository {
  final infractionDS = InfractionDataSource();

  List<InfractionEntity> fetchAllInfractions() {
    List<InfractionDTO> infractionsBrut = infractionDS.fetchAllInfractions() as List<InfractionDTO>;

    return _convertDatasToEntities(infractionsBrut);
  }

  List<InfractionEntity> _convertDatasToEntities(List<InfractionDTO> infractionsBrut) {
    List<InfractionEntity> infEntities = [];

    for (InfractionDTO inf in infractionsBrut) {
      InfractionEntity infEnt = InfractionEntity(inf.dpsLongLabel, inf.dpsArticle, inf.dpsPunissable, inf.dpsIntention, inf.dpsElemMat, inf.dpsDesc);

      infEntities.add(infEnt);
    }

    return infEntities;
  }
}
