import 'package:acervus_app/models/obra_model.dart';

class AtracaoModel {
  final String id;
  final String nome;
  final String description;
  final bool disponibilidade;
  final List<ObraModel> obras;

  AtracaoModel({
      required this.id, 
      required this.nome, 
      required this.obras,
      required this.description,
      required this.disponibilidade
    });

  factory AtracaoModel.fromJson(Map<String, dynamic> dado) {
    return AtracaoModel(
      id: dado['id'], 
      nome: dado['nome'], 
      description: dado['description'],
      disponibilidade: dado['disponibilidade'],
      obras: dado['obras'] != null 
      ? ((dado['obras'] as List).map((obra) => ObraModel.fromJson(obra)).toList()) 
      : []
    );
  }
}
