class InfractionDTO {
  final int id;
  final String label;
  final String? answer;
  final String file;
  final String category;
  final String? subcategory;
  final String? type;
  final String? dpsLongLabel;
  final String? dpsArticle;
  final String? dpsPunissable;
  final String? dpsIntention;
  final String? dpsElemMat;
  final String? dpsDesc;
  final String? month;
  bool dontshow;

  InfractionDTO(
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

  factory InfractionDTO.fromJson(Map<String, dynamic> json) {
    return InfractionDTO(
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
}
