// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TableBarcode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableBarcodeAdapter extends TypeAdapter<TableBarcode> {
  @override
  final int typeId = 0;

  @override
  TableBarcode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableBarcode(
      Label: fields[0] as String,
      UserName: fields[1] as String,
      Password: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TableBarcode obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.Label)
      ..writeByte(1)
      ..write(obj.UserName)
      ..writeByte(2)
      ..write(obj.Password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableBarcodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
