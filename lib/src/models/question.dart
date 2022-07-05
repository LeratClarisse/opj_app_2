class Question {
  final int id;
  final String label;
  final String answer;
  final String file;
  final String category;
  final String? subcategory;
  final String? type;

  const Question({required this.id, required this.label, required this.answer, required this.file, required this.category, this.subcategory, this.type});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(id: json['Id'], label: json['Label'], answer: json['Answer'], file: json['File'], category: json['Category'], subcategory: json['Subcategory'], type: json['Type']);
  }
}
