import 'package:flutter/material.dart';
import 'package:acervus_app/models/atracao_model.dart';
import 'package:acervus_app/pages/atracao/atracoes_page.dart';
import 'package:acervus_app/functions/atracao/atualizar_atracao_function.dart';

class AtualizarAtracaoPage extends StatefulWidget {
  final AtracaoModel atracao;
  
  AtualizarAtracaoPage({super.key, required AtracaoModel this.atracao});

  @override
  State<AtualizarAtracaoPage> createState() => _AtualizarAtracaoPageState();
}

class _AtualizarAtracaoPageState extends State<AtualizarAtracaoPage> {
  final _formKey = GlobalKey<FormState>();
  //
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  //
  final regexGeral = RegExp(r'^[a-zA-ZÀ-ÿ\s]{4,}$');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atualizar',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "${widget.atracao.nome}",
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
                    "Nome: ${widget.atracao.nome}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Descrição: ${widget.atracao.description}",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                ]  
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Atualizar Atração',
                      style: TextStyle(
                      fontSize: 32,
                      ),
                    ),  
                    SizedBox(height: 16,),
                    SizedBox(
                      width: 900,
                      child: TextFormField(
                        controller: _nomeController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo Nome';
                          }

                          if (!regexGeral.hasMatch(value.trim())) {
                            return 'Campo inválido. Apenas letras (min. 4 caracteres)';
                          }
                      
                          return null;
                        }
                      ),
                    ),
                    SizedBox(height: 16,),
                    SizedBox(
                      width: 900,
                      child: TextFormField(
                        controller: _descricaoController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo Descrição';
                          }

                          if (!regexGeral.hasMatch(value.trim())) {
                            return 'Campo inválido. Apenas letras (min. 4 caracteres)';
                          }
                      
                          return null;
                        }
                      ),
                    ),
                    SizedBox(height: 16,),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final nome = _nomeController.text.trim();
                          final descricao = _descricaoController.text.trim();

                          atualizarAtracaoFunction(nome, descricao, widget.atracao.id);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Atração atualizada com sucesso'),
                              duration: Duration(seconds: 3),
                            ),
                          );

                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Falha ao atualizar atração"),
                              duration: Duration(seconds: 3),
                            )
                          );
                        }
                      },
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: Center(
                          child: Text('Atualizar',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}