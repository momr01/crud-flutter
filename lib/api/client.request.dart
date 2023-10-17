import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_crud/models/client.model.dart';

// 'http://192.168.0.7:4002/api/clients'
//'http://192.168.0.7:4002/api/clients/register'
// 'http://192.168.0.7:4002/api/clients/update'
//'http://192.168.0.7:4002/api/clients/delete/$clientId'

Future<List<Client>> listClients() async {
  final response = await http
      .get(Uri.parse('https://flutter-crud-api-vert.vercel.app/api/clients'));

  return compute(decodeJson, response.body);
}

List<Client> decodeJson(String responseBody) {
  //se conviergte el body de la response en un JSON
  final myJson = json.decode(responseBody);

//convertimos JSON a objeto de tipo cliente y lo retornamos, en este caso es una lista de clientes
  return myJson['clients']
      .map<Client>((json) => Client.fromJson(json))
      .toList();
}

mapClient(Client client, bool mapId) {
  Map data;

//si vamos a crear no enviamos el id ya que es autogenerado por DB
  if (!mapId) {
    data = {
      'name': '${client.name}',
      'surname': '${client.surname}',
      'phone': '${client.phone}'
    };
    //si vamos a modificar un cliente, enviamos el objeto cliente con su id
  } else {
    data = {
      '_id': '${client.id}',
      'name': '${client.name}',
      'surname': '${client.surname}',
      'phone': '${client.phone}'
    };
  }

  return data;
}

Future<Client> addClient(Client client) async {
  var url = Uri.parse(
      'https://flutter-crud-api-vert.vercel.app/api/clients/register');
  var newBody = json.encode(mapClient(client, false));

  var response = await http.post(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: newBody);

  if (response.statusCode == 200) {
    return Client.fromJson(jsonDecode(response.body)['client']);
  } else {
    throw Exception("Error al intentar registrar el cliente!");
  }
}

Future<Client> modifyClient(Client client) async {
  var url =
      Uri.parse('https://flutter-crud-api-vert.vercel.app/api/clients/update');
  var newBody = json.encode(mapClient(client, true));

  var response = await http.put(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: newBody);

  if (response.statusCode == 200) {
    return Client.fromJson(jsonDecode(response.body)['client']);
  } else {
    throw Exception("Error al intentar modificar el cliente!");
  }
}

Future<Client> deleteClient(String clientId) async {
  final response = await http.delete(
    Uri.parse(
        'https://flutter-crud-api-vert.vercel.app/api/clients/delete/$clientId'),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
  );

  if (response.statusCode == 200) {
    return Client.fromJson(jsonDecode(response.body)['client']);
  } else {
    throw Exception("Error al intentar eliminar el cliente!");
  }
}
