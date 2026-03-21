import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:acervus_app/models/obra_model.dart';

Future<List<ObraModel>> buscarObrasFunction () async {
  final response = await http.get(
    Uri.parse("http://localhost:3000/api/obras")
  );

  if (response.statusCode == 200) {
    List dados = jsonDecode(response.body);

    return dados.map(
      (dado) => ObraModel.fromJson(dado)
    ).toList();
  } else {
    throw Exception("Erro ao buscar dados");
  }
}