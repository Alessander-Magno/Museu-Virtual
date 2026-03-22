import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:acervus_app/models/atracao_model.dart';

Future<AtracaoModel> buscarAtracaoFunction (String id) async {
  final response = await http.get(
    Uri.parse("http://localhost:3000/api/atracoes/$id")
  );

  if (response.statusCode == 200) {
    final dado = jsonDecode(response.body);

    return AtracaoModel.fromJson(dado);
  } else {
    throw Exception("Erro ao buscar dados");
  }
}