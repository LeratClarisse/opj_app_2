import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/Data/DTO/question_dto.dart';
import '../Domain/infraction_entity.dart';
import 'infraction_datasource.dart';

class InfractionRepository {
  Future<List<InfractionEntity>> fetchAllInfractions() async {
    if (!await Hive.boxExists('questions') || !Hive.box('questions').containsKey('infractionEntities')) {
      Hive.registerAdapter(InfractionEntityAdapter());
      InfractionDataSource infractionDS = InfractionDataSource();
      List<QuestionDTO> infractionsBrut = await infractionDS.fetchAllInfractions();
      Hive.box('questions').put('infractionEntities', _convertDatasToEntities(infractionsBrut));
    }

    return Hive.box('questions').get('infractionEntities');
  }

  List<InfractionEntity> _convertDatasToEntities(List<QuestionDTO> infractionsBrut) {
    List<InfractionEntity> infEntities = [];

    for (QuestionDTO inf in infractionsBrut) {
      InfractionEntity infEnt = InfractionEntity(inf.label, inf.dpsLongLabel, inf.dpsArticle, inf.dpsPunissable,
          inf.dpsIntention, inf.dpsElemMat, inf.dpsDesc);

      infEntities.add(infEnt);
    }

    return infEntities;
  }
}
