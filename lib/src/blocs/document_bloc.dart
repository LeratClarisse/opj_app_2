import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/document.dart';

class DocumentsBloc {
  final _repository = Repository();
  final _documentsFetcher = PublishSubject<List<Document>>();
  List<Document>? courses;

  Stream<List<Document>> get allCourses => _documentsFetcher.stream;
  Stream<List<Document>> get allSumUps => _documentsFetcher.stream;

  fetchAllCourses() async {
    if (courses == null) {
      courses = await _repository.fetchAllCourses();
      _documentsFetcher.sink.add(courses!);
    } else {
      _documentsFetcher.sink.add(courses!);
    }
  }

  sortDocument(String column, bool asc) {
    switch (column) {
      case 'Title':
        if (asc == true) {
          courses!.sort((docA, docB) => docA.title.compareTo(docB.title));
        } else {
          courses!.sort((docB, docA) => docA.title.compareTo(docB.title));
        }
        break;
      case 'Category':
        if (asc == true) {
          courses!.sort((docA, docB) => docA.category.compareTo(docB.category));
        } else {
          courses!.sort((docB, docA) => docA.category.compareTo(docB.category));
        }
        break;
      case 'Subcategory':
        if (asc == true) {
          courses!.sort(
              (docA, docB) => docA.subcategory.compareTo(docB.subcategory));
        } else {
          courses!.sort(
              (docB, docA) => docA.subcategory.compareTo(docB.subcategory));
        }
        break;
      default:
        break;
    }
  }

  getDocumentByName(String name) async {
    await _repository.getDocumentByName(name);
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
