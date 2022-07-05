class Document {
  final int id;
  final int docNumber;
  final String title;
  final String file;
  final String category;
  final String? subcategory;
  final bool isSumUp;

  const Document({required this.id, required this.docNumber, required this.title, required this.file, required this.category, this.subcategory, this.isSumUp = false});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(id: json['id'], docNumber: json['docNumber'], title: json['title'], file: json['file'], category: json['category'], subcategory: json['subcategory'], isSumUp: json['isSumUp'] ?? false);
  }
}
