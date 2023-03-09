// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionDTOAdapter extends TypeAdapter<QuestionDTO> {
  @override
  final int typeId = 2;

  @override
  QuestionDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionDTO(
      id: fields[0] as int,
      label: fields[1] as String,
      answer: fields[2] as String?,
      file: fields[3] as String,
      category: fields[4] as String,
      subcategory: fields[5] as String?,
      type: fields[6] as String?,
      dpsLongLabel: fields[7] as String?,
      dpsArticle: fields[8] as String?,
      dpsPunissable: fields[9] as String?,
      dpsIntention: fields[10] as String?,
      dpsElemMat: fields[11] as String?,
      dpsDesc: fields[12] as String?,
      month: fields[13] as String?,
      dontshow: fields[14] == null ? false : fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionDTO obj) {
    writer
      ..writeByte(15)
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
      ..write(obj.subcategory)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.dpsLongLabel)
      ..writeByte(8)
      ..write(obj.dpsArticle)
      ..writeByte(9)
      ..write(obj.dpsPunissable)
      ..writeByte(10)
      ..write(obj.dpsIntention)
      ..writeByte(11)
      ..write(obj.dpsElemMat)
      ..writeByte(12)
      ..write(obj.dpsDesc)
      ..writeByte(13)
      ..write(obj.month)
      ..writeByte(14)
      ..write(obj.dontshow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
