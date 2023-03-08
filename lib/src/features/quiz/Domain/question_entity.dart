import 'package:hive/hive.dart';

part 'question_entity.g.dart';

@HiveType(typeId: 0)
class QuestionEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String label;
  @HiveField(2)
  final String? answer;
  @HiveField(3)
  final String file;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final String? dpsLongLabel;
  @HiveField(6)
  final String? dpsArticle;
  @HiveField(7)
  final String? dpsPunissable;
  @HiveField(8)
  final String? dpsIntention;
  @HiveField(9)
  final String? dpsElemMat;
  @HiveField(10)
  final String? dpsDesc;
  @HiveField(11, defaultValue: false)
  bool dontshow;

  QuestionEntity(this.id, this.label, this.answer, this.file, this.category, this.dpsLongLabel, this.dpsArticle,
      this.dpsPunissable, this.dpsIntention, this.dpsElemMat, this.dpsDesc,
      {this.dontshow = false});
}
