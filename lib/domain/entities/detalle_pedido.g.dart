// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detalle_pedido.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetallePedidoAdapter extends TypeAdapter<DetallePedido> {
  @override
  final int typeId = 1;

  @override
  DetallePedido read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetallePedido(
      plato: fields[3] as Plato,
      cantidadPlato: fields[1] as int,
      valorTotal: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DetallePedido obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cantidadPlato)
      ..writeByte(2)
      ..write(obj.valorTotal)
      ..writeByte(3)
      ..write(obj.plato);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetallePedidoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
