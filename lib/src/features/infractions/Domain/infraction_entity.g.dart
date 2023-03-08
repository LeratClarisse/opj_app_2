// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infraction_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InfractionEntityAdapter extends TypeAdapter<InfractionEntity> {
  @override
  final int typeId = 1;

  @override
  InfractionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfractionEntity(
      fields[0] as String,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InfractionEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.dpsLongLabel)
      ..writeByte(2)
      ..write(obj.dpsArticle)
      ..writeByte(3)
      ..write(obj.dpsPunissable)
      ..writeByte(4)
      ..write(obj.dpsIntention)
      ..writeByte(5)
      ..write(obj.dpsElemMat)
      ..writeByte(6)
      ..write(obj.dpsDesc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfractionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
