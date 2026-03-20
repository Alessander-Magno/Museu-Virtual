class AtracaoModel {
  final String id;
  final String nome;
  final String description;

  AtracaoModel({
      required this.id, 
      required this.nome, 
      required this.description
    });

  factory AtracaoModel.fromJson(Map<String, dynamic> dado) {
    return AtracaoModel(
      id: dado['id'], 
      nome: dado['nome'], 
      description: dado['description']
    );
  }
}
