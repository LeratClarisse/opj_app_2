import 'package:opjapp/src/features/infractions/Data/infraction_repository.dart';
import 'package:opjapp/src/features/infractions/Domain/infraction_entity.dart';

class InfractionUsecase {
  List<InfractionEntity> _infractions = [];
  final _repository = InfractionRepository();

  fetchAllInfractions() {
    _infractions = _repository.fetchAllInfractions();
    return _infractions;
  }

  searchDps(String search) {
    if (search.isEmpty) {
      return _infractions;
    } else {
      return _infractions.where((q) => q.dpsLongLabel!.toLowerCase().contains(search.toLowerCase())).toList();
    }
  }
}
