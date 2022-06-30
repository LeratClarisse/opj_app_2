import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/document.dart';

class DocumentsBloc {
  final _repository = Repository();
  final _documentsFetcher = PublishSubject<List<Document>>();

  Stream<List<Document>> get allDocuments => _documentsFetcher.stream;

  fetchAllDocuments() async {
    List<Document> documents = await _repository.fetchAllDocuments();
    _documentsFetcher.sink.add(documents);
  }

  dispose() {
    _documentsFetcher.close();
  }
}

final bloc = DocumentsBloc();
