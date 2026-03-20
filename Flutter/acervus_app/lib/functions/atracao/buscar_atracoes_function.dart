import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:acervus_app/models/atracao_model.dart';

Future<List<AtracaoModel>> buscarAtracoes () async {
  final response = await http.get(
    Uri.parse("http://localhost:3000/api/atracoes")
  );

  if (response.statusCode == 200) {
    List dados = jsonDecode(response.body);

    return dados.map(
      (dado) => AtracaoModel.fromJson(dado)
    ).toList();
  } else {
    throw Exception("Erro ao buscar dados");
  }
}