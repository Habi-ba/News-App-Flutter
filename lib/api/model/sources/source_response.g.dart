// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SourceResponseAdapter extends TypeAdapter<SourceResponse> {
  @override
  final typeId = 1;

  @override
  SourceResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SourceResponse(
      status: fields[0] as String?,
      source: (fields[1] as List?)?.cast<Source>(),
      code: fields[3] as String?,
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SourceResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.source)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
