import 'package:flutter/material.dart';
import 'package:acervus_app/functions/atracao/buscar_atracoes_function.dart';

class AtracoesPage extends StatefulWidget {
  const AtracoesPage({super.key});

  @override
  State<AtracoesPage> createState() => _AtracoesPageState();
}

class _AtracoesPageState extends State<AtracoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: buscarAtracoes(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator()
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar', 
                style: TextStyle(
                  fontSize: 22,
                ),
              )
            );
          }

          final atracoes = snapshot.data!;

          return ListView.builder(
            itemCount: atracoes.length,
            itemBuilder: (context, index) {
              final atracao = atracoes[index];

              return ListTile(
                title: Text(atracao.nome),
                subtitle: Text(atracao.description),
              );
            },

          );
        }
      ),
    );
  }
}