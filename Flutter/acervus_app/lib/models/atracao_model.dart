class AtracaoModel {
  final String id;
  final String nome;
  final String description;
  final bool disponibilidade;

  AtracaoModel({
      required this.id, 
      required this.nome, 
      required this.description,
      required this.disponibilidade
    });

  factory AtracaoModel.fromJson(Map<String, dynamic> dado) {
    return AtracaoModel(
      id: dado['id'], 
      nome: dado['nome'], 
      description: dado['description'],
      disponibilidade: dado['disponibilidade']
    );
  }
}
