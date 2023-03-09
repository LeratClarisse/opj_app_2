class QuestionEntity {
  final int id;
  final String label;
  final String? answer;
  final String file;
  final String category;
  final String? dpsLongLabel;
  final String? dpsArticle;
  final String? dpsPunissable;
  final String? dpsIntention;
  final String? dpsElemMat;
  final String? dpsDesc;
  bool dontshow;

  QuestionEntity(this.id, this.label, this.answer, this.file, this.category, this.dpsLongLabel, this.dpsArticle,
      this.dpsPunissable, this.dpsIntention, this.dpsElemMat, this.dpsDesc,
      {this.dontshow = false});
}
