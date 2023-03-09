import 'package:opjapp/src/core/Data/DTO/question_dto.dart';

import '../Domain/question_entity.dart';
import 'quiz_datasource.dart';

class QuestionRepository {
  Future<List<QuestionEntity>> fetchAllQuestions(String course, String category, String subcategory, String month) async {
    QuestionDataSource questionDS = QuestionDataSource();
    List<QuestionDTO> questionsBrut = await questionDS.fetchAllQuestions(course, category, subcategory, month);
    return _convertDatasToEntities(questionsBrut);
  }

  List<QuestionEntity> _convertDatasToEntities(List<QuestionDTO> questionsBrut) {
    List<QuestionEntity> questEntities = [];

    for (QuestionDTO quest in questionsBrut) {
      QuestionEntity questEnt = QuestionEntity(quest.id, quest.label, quest.answer, quest.file, quest.category,
          quest.dpsLongLabel, quest.dpsArticle, quest.dpsPunissable, quest.dpsIntention, quest.dpsElemMat, quest.dpsDesc,
          dontshow: quest.dontshow);

      questEntities.add(questEnt);
    }

    return questEntities;
  }
}
