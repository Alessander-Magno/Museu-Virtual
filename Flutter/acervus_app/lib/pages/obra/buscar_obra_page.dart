import 'package:flutter/material.dart';

import 'package:acervus_app/models/obra_model.dart';

class BuscarObraPage extends StatelessWidget {
  final ObraModel obra;
  
  const BuscarObraPage({super.key, required this.obra});

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
              obra.title,
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
                    "ID: ${obra.id}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Titulo: ${obra.title}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                   Text(
                    "Autor: ${obra.autor}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Descrição: ${obra.description}",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  Text(
                    "AtracaoId: ${obra.atracaoId}",
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