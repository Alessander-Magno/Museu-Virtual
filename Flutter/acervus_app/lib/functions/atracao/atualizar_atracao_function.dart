import 'dart:convert';
import "package:http/http.dart" as http;

Future<bool> atualizarAtracaoFunction (String nome, String description, String id) async {
  final url = Uri.parse("http://localhost:3000/api/atracoes/$id");

  final response = await http.patch(
    url,
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "nome": nome,
      "description": description
    })
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}