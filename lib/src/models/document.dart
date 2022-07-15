class Document {
  final int id;
  final String file;
  final String title;
  final String category;
  final String? subcategory;

  const Document({required this.id, required this.file, required this.title, required this.category, this.subcategory});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(id: json['Id'], file: json['File'], title: json['Title'], category: json['Category'], subcategory: json['Subcategory']);
  }
}
