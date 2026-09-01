import 'dart:convert';
import 'package:la_carreta_express_cs/domain/datasource/cliente_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClienteDataSourceImpl extends ClienteDataSource {
  static const _profileKey = 'customerProfile';

  @override
  Future<Cliente> getCustomer({required String idCliente}) async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_profileKey);
    if (raw == null) throw Exception('Cliente no encontrado');
    return _fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<Cliente> updateCustomer({required Cliente cliente}) async {
    await _save(cliente);
    return cliente;
  }

  @override
  Future<Cliente> createCustomer({
    required Cliente cliente,
    required String uuid,
  }) async {
    await _save(cliente);
    return cliente;
  }

  Future<void> _save(Cliente cliente) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _profileKey,
      jsonEncode({
        'id': cliente.id,
        'nombre': cliente.nombre,
        'apellido': cliente.apellido,
        'celular': cliente.celular,
        'correo': cliente.correo,
        'direccion': cliente.direccion,
        'uuid': cliente.uuid,
        'imgUrl': cliente.imgUrl,
      }),
    );
  }

  Cliente _fromJson(Map<String, dynamic> json) => Cliente(
        id: json['id']?.toString() ?? '',
        nombre: json['nombre']?.toString() ?? '',
        apellido: json['apellido']?.toString() ?? '',
        celular: json['celular']?.toString() ?? '',
        correo: json['correo']?.toString() ?? '',
        direccion: json['direccion']?.toString() ?? '',
        uuid: json['uuid']?.toString() ?? '',
        imgUrl: json['imgUrl']?.toString() ?? '',
      );
}
