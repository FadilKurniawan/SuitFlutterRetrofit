// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 1;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      needs: fields[3] as String,
      address: fields[4] as String,
      residentsNumber: fields[5] as int,
      residentsDescription: fields[6] as String,
      status: fields[7] as String,
      placesSlug: fields[8] as String,
      phoneMessage: fields[9] as String,
      phoneCall: fields[10] as String,
      whatsappNumber: fields[11] as String,
      latitude: fields[12] as double,
      longitude: fields[13] as double,
      publishedAt: fields[14] as DateTime,
      createdAt: fields[15] as DateTime,
      updatedAt: fields[16] as DateTime,
      placeCategory: fields[17] as PlaceCategory,
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.needs)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.residentsNumber)
      ..writeByte(6)
      ..write(obj.residentsDescription)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.placesSlug)
      ..writeByte(9)
      ..write(obj.phoneMessage)
      ..writeByte(10)
      ..write(obj.phoneCall)
      ..writeByte(11)
      ..write(obj.whatsappNumber)
      ..writeByte(12)
      ..write(obj.latitude)
      ..writeByte(13)
      ..write(obj.longitude)
      ..writeByte(14)
      ..write(obj.publishedAt)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.updatedAt)
      ..writeByte(17)
      ..write(obj.placeCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
