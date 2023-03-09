import 'package:hive/hive.dart';

part 'question_dto.g.dart';

@HiveType(typeId: 2)
class QuestionDTO {
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
  final String? subcategory;
  @HiveField(6)
  final String? type;
  @HiveField(7)
  final String? dpsLongLabel;
  @HiveField(8)
  final String? dpsArticle;
  @HiveField(9)
  final String? dpsPunissable;
  @HiveField(10)
  final String? dpsIntention;
  @HiveField(11)
  final String? dpsElemMat;
  @HiveField(12)
  final String? dpsDesc;
  @HiveField(13)
  final String? month;
  @HiveField(14, defaultValue: false)
  bool dontshow;

  QuestionDTO(
      {required this.id,
      required this.label,
      this.answer,
      required this.file,
      required this.category,
      this.subcategory,
      this.type,
      this.dpsLongLabel,
      this.dpsArticle,
      this.dpsPunissable,
      this.dpsIntention,
      this.dpsElemMat,
      this.dpsDesc,
      this.month,
      this.dontshow = false});

  factory QuestionDTO.fromJson(Map<String, dynamic> json) {
    return QuestionDTO(
        id: json['Id'],
        label: json['Label'],
        answer: json['Answer'],
        file: json['File'],
        category: json['Category'],
        subcategory: json['Subcategory'],
        type: json['Type'],
        dpsLongLabel: json['DPS_LongLabel'],
        dpsArticle: json['DPS_Article'],
        dpsPunissable: json['DPS_Punissable'],
        dpsIntention: json['DPS_Intention'],
        dpsElemMat: json['DPS_ElemMat'],
        dpsDesc: json['DPS_Desc'],
        month: json['Month']);
  }

  Map toJson() => {
        'Id': id,
        'Label': label,
        'Answer': answer,
        'File': file,
        'Category': category,
        'Subcategory': subcategory,
        'Type': type,
        'DPS_LongLabel': dpsLongLabel,
        'DPS_Article': dpsArticle,
        'DPS_Punissable': dpsPunissable,
        'DPS_Intention': dpsIntention,
        'DPS_ElemMat': dpsElemMat,
        'DPS_Desc': dpsDesc,
        'Month': month
      };
}
