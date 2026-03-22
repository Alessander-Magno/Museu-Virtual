import "package:http/http.dart" as http;

Future<bool> deletarObraFunction (String id) async {
  final response = await http.delete(
    Uri.parse("http://localhost:3000/api/obras/$id"),
  );

  if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
    return true;
  } else {
    return false;
  }
}