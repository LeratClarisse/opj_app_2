import 'dart:async';
import 'dart:convert';
import '../models/document.dart';

class DocumentProvider {
  final response = '''{"documents": [
    {"id": 1, "docNumber": 1, "title": "Doc1", "file": "doc1.pdf", "category": "DPG" },
    {"id": 2, "docNumber": 2, "title": "Doc2", "file": "doc2.pdf", "category": "DPS" },
    {"id": 3, "docNumber": 3, "title": "Doc3", "file": "doc3.pdf", "category": "DPG" },
    {"id": 4, "docNumber": 4, "title": "Doc4", "file": "doc4.pdf", "category": "DPS" },
    {"id": 5, "docNumber": 5, "title": "Doc5", "file": "doc5.pdf", "category": "PP" },
    {"id": 6, "docNumber": 6, "title": "Recap1", "file": "recap1.pdf", "category": "DPG", "isSumUp": true },
    {"id": 7, "docNumber": 7, "title": "Recap2", "file": "recap2.pdf", "category": "DPS", "isSumUp": true }]}''';

  Future<List<Document>> fetchCourseList() async {
    if (response.isNotEmpty) {
      Iterable l = json.decode(response)['documents'];
      List<Document> documents = List<Document>.from(l.map((model) => Document.fromJson(model)));
      return documents;
    } else {
      throw Exception('Failed to load documents');
    }
  }

  Future<List<Document>> fetchSumUpList() async {
    if (response.isNotEmpty) {
      Iterable l = json.decode(response)['documents'];
      List<Document> documents = List<Document>.from(l.map((model) => { if(model['isSumUp']) {Document.fromJson(model)}));
      return documents;
    } else {
      throw Exception('Failed to load documents');
    }
  }
}
