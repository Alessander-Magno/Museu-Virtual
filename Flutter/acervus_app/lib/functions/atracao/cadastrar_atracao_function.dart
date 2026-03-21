import 'dart:convert';
import "package:http/http.dart" as http;

Future<bool> cadastrarAtracaoFunction (String nome, String description) async {
  final url = Uri.parse("http://localhost:3000/api/atracoes");

  final response = await http.post(
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