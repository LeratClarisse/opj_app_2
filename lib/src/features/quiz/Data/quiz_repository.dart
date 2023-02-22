import 'package:flutter/foundation.dart';
import 'package:opjapp/src/core/Data/DTO/question_dto.dart';

import '../Domain/question_entity.dart';
import 'quiz_json_datasource.dart';
import 'quiz_sqlite_datasource.dart';

class QuestionRepository {
  // ignore: prefer_typing_uninitialized_variables
  late var questionDS;

  List<QuestionEntity> fetchAllQuestions(String course, String category, String subcategory, String month) {
    if (kIsWeb) {
      questionDS = QuestionJsonDataSource();
    } else {
      questionDS = QuestionSqliteDataSource();
    }

    List<QuestionDTO> questionsBrut = questionDS.fetchAllInfractions(course, category, subcategory, month) as List<QuestionDTO>;

    return _convertDatasToEntities(questionsBrut);
  }

  List<QuestionEntity> _convertDatasToEntities(List<QuestionDTO> questionsBrut) {
    List<QuestionEntity> questEntities = [];

    for (QuestionDTO quest in questionsBrut) {
      QuestionEntity questEnt = QuestionEntity(quest.id, quest.label, quest.answer, quest.file, quest.category, quest.dpsLongLabel, quest.dpsArticle,
          quest.dpsPunissable, quest.dpsIntention, quest.dpsElemMat, quest.dpsDesc,
          dontshow: quest.dontshow);

      questEntities.add(questEnt);
    }

    return questEntities;
  }
}
