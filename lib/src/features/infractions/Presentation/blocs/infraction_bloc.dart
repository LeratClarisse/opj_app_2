import 'package:opjapp/src/features/infractions/Domain/infraction_entity.dart';
import 'package:opjapp/src/features/infractions/Domain/infraction_usecase.dart';
import 'package:rxdart/rxdart.dart';

class InfractionsBloc {
  final _usecase = InfractionUsecase();
  final _allInfractionsFetcher = PublishSubject<List<InfractionEntity>>();

  Stream<List<InfractionEntity>> get allInfractions => _allInfractionsFetcher.stream;

  fetchAllInfractions() {
    _allInfractionsFetcher.sink.add([]);
    _allInfractionsFetcher.sink.add(_usecase.fetchAllInfractions());
  }
  
  searchDps({String search = ''}) {
      _allInfractionsFetcher.sink.add([]);
      _allInfractionsFetcher.sink.add(_usecase.searchDps(search));
  }

  dispose() {
    _allInfractionsFetcher.close();
  }
}

final bloc = InfractionsBloc();
