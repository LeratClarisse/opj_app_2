import 'package:hive/hive.dart';

part 'infraction_entity.g.dart';

@HiveType(typeId: 1)
class InfractionEntity {
  @HiveField(0)
  final String label;
  @HiveField(1)
  final String? dpsLongLabel;
  @HiveField(2)
  final String? dpsArticle;
  @HiveField(3)
  final String? dpsPunissable;
  @HiveField(4)
  final String? dpsIntention;
  @HiveField(5)
  final String? dpsElemMat;
  @HiveField(6)
  final String? dpsDesc;

  InfractionEntity(this.label, this.dpsLongLabel, this.dpsArticle, this.dpsPunissable, this.dpsIntention,
      this.dpsElemMat, this.dpsDesc);
}
