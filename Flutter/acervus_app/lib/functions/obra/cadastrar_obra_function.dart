import 'dart:convert';
import "package:http/http.dart" as http;

Future<bool> cadastrarObraFunction ({required String title, required String description, String autor = 'desconhecido', required String atracaoId}) async {
  final url = Uri.parse("http://localhost:3000/api/obras");

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "title": title,
      "autor": autor,
      "atracaoId": atracaoId,
      "description": description
    })
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}