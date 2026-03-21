import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:acervus_app/models/obra_model.dart';

Future<ObraModel> buscarObraFunction (String id) async {
  final response = await http.get(
    Uri.parse("http://localhost:3000/api/obras/$id")
  );

  if (response.statusCode == 200) {
    final dado = jsonDecode(response.body);

    return ObraModel(
      id: dado['id'], 
      autor: dado['autor'], 
      title: dado['title'], 
      atracaoId: dado['atracaoId'], 
      description: dado['description']
    );
  } else {
    throw Exception("Erro ao buscar dados");
  }
}