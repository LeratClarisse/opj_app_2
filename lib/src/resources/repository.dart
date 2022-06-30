import 'dart:async';
import 'document_provider.dart';
import '../models/document.dart';

class Repository {
  final documentProvider = DocumentProvider();

  Future<List<Document>> fetchAllDocuments() => documentProvider.fetchDocumentList();
}
