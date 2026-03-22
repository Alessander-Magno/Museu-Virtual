import 'package:acervus_app/functions/atracao/buscar_atracao_function.dart';
import 'package:flutter/material.dart';

import 'package:acervus_app/models/obra_model.dart';

class BuscarObraPage extends StatefulWidget {
  final ObraModel obra;
  
  const BuscarObraPage({super.key, required this.obra});

  @override
  State<BuscarObraPage> createState() => _BuscarObraPageState();
}

class _BuscarObraPageState extends State<BuscarObraPage> {
  String? nomeAtracao;

  @override
  void initState() {
    super.initState();
    carregarNomeAtracao(widget.obra.atracaoId);
  }

  @override
  Widget build(BuildContext context) {

    if (nomeAtracao == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buscar',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.obra.title,
              style: TextStyle(
                fontSize: 62,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 700,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1
                ),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID: ${widget.obra.id}",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "Titulo: ${widget.obra.title}",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                   Text(
                    "Autor: ${widget.obra.autor}",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "Descrição: ${widget.obra.description}",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "Atração vinculada: $nomeAtracao",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ]  
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> carregarNomeAtracao(String id) async {
    try {
      final atracao = await buscarAtracaoFunction(id);

      setState(() {
        nomeAtracao = atracao.nome;
      });
    } catch (e) {
      print(e);
    }
  }
}