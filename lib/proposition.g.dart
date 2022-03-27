// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PropositionAdapter extends TypeAdapter<Proposition> {
  @override
  final int typeId = 0;

  @override
  Proposition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Proposition(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Proposition obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entreprise)
      ..writeByte(1)
      ..write(obj.salaireBrutAnuel)
      ..writeByte(2)
      ..write(obj.statutPropose)
      ..writeByte(3)
      ..write(obj.salaireNetMensuel)
      ..writeByte(4)
      ..write(obj.mesSentiments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
