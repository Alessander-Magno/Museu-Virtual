class ObraModel {
  final String id;
  final String autor;
  final String title;
  final String atracaoId;
  final String description;

  ObraModel({
    required this.id,
    required this.autor,
    required this.title,
    required this.atracaoId,
    required this.description,
  });

  factory ObraModel.fromJson(Map<String, dynamic> dado) {
    return ObraModel(
      id: dado['id'], 
      autor: dado['autor'], 
      title: dado['title'], 
      atracaoId: dado['atracaoId'], 
      description: dado['description']
    );
  }
}