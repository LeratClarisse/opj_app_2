import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/document.dart';

class DocumentsBloc {
  final _repository = Repository();
  final _documentsFetcher = PublishSubject<List<Document>>();

  Stream<List<Document>> get allCourses => _documentsFetcher.stream;
  Stream<List<Document>> get allSumUps => _documentsFetcher.stream;

  fetchAllCourses() async {
    List<Document> courses = await _repository.fetchAllCourses();
    _documentsFetcher.sink.add(courses);
  }

  fetchAllSumUps() async {
    List<Document> sumUps = await _repository.fetchAllSumUps();
    _documentsFetcher.sink.add(sumUps);
  }

  dispose() {
    _documentsFetcher.close();
  }
}

final bloc = DocumentsBloc();
