class Question {
  final int id;
  final String label;
  final String response;
  final int docNumber;
  final int category;
  final int? subcategory;

  const Question({required this.id, required this.label, required this.response, required this.docNumber, required this.category, this.subcategory});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(id: json['id'], label: json['label'], response: json['response'], docNumber: json['courseSumUp'], category: json['category'], subcategory: json['subcategory']);
  }
}
