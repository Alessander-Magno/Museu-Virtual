import 'dart:convert';
import "package:http/http.dart" as http;

Future<bool> atualizarObraFunction ({required String title, required String description, String autor = 'desconhecido', required String id}) async {
  final url = Uri.parse("http://localhost:3000/api/obras/${id}");

  final response = await http.patch(
    url,
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "title": title,
      "autor": autor,
      "description": description
    })
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}