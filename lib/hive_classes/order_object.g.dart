// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 1;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      id: fields[0] as String,
      products: (fields[1] as List)
          .map((dynamic e) => (e as Map).cast<String, int>())
          .toList(),
      customerName: fields[2] as String,
      customerPhNo: fields[3] as int,
      dateTime: fields[4] as DateTime,
      totalJmp: fields[5] as int,
      totalMrp: fields[6] as int,
      totalPaid: fields[7] as int,
      paymentType: fields[8] as String,
      notes: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.products)
      ..writeByte(2)
      ..write(obj.customerName)
      ..writeByte(3)
      ..write(obj.customerPhNo)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.totalJmp)
      ..writeByte(6)
      ..write(obj.totalMrp)
      ..writeByte(7)
      ..write(obj.totalPaid)
      ..writeByte(8)
      ..write(obj.paymentType)
      ..writeByte(9)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
