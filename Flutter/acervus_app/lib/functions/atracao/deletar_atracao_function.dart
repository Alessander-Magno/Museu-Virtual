import 'dart:convert';
import "package:http/http.dart" as http;

Future<bool> deletarAtracaoFunction (String id) async {
  final response = await http.delete(
    Uri.parse("http://localhost:3000/api/atracoes/${id}"),
  );

  if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
    return true;
  } else {
    return false;
  }
}