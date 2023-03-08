// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionEntityAdapter extends TypeAdapter<QuestionEntity> {
  @override
  final int typeId = 0;

  @override
  QuestionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionEntity(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String?,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[8] as String?,
      fields[9] as String?,
      fields[10] as String?,
      dontshow: fields[11] == null ? false : fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.file)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.dpsLongLabel)
      ..writeByte(6)
      ..write(obj.dpsArticle)
      ..writeByte(7)
      ..write(obj.dpsPunissable)
      ..writeByte(8)
      ..write(obj.dpsIntention)
      ..writeByte(9)
      ..write(obj.dpsElemMat)
      ..writeByte(10)
      ..write(obj.dpsDesc)
      ..writeByte(11)
      ..write(obj.dontshow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
