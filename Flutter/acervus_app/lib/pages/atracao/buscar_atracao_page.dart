import 'package:acervus_app/models/atracao_model.dart';
import 'package:flutter/material.dart';

class BuscarAtracaoPage extends StatelessWidget {
  final AtracaoModel atracao;
  
  const BuscarAtracaoPage({super.key, required this.atracao});

  @override
  Widget build(BuildContext context) {
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
              atracao.nome,
              style: TextStyle(
                fontSize: 62,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
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
                    "ID: ${atracao.id}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Nome: ${atracao.nome}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Descrição: ${atracao.description}",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  Text("Disponibilidade: ${(atracao.disponibilidade) ? "sim" : "não"}",
                    style: TextStyle(
                      fontSize: 25
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
}