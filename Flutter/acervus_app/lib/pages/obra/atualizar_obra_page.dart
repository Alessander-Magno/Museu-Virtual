import 'dart:js_interop';

import 'package:flutter/material.dart';

import 'package:acervus_app/models/obra_model.dart';

import 'package:acervus_app/functions/obra/atualizar_obra_function.dart';

class AtualizarObraPage extends StatefulWidget {
  final ObraModel obra;
  
  AtualizarObraPage({super.key, required ObraModel this.obra});

  @override
  State<AtualizarObraPage> createState() => _AtualizarObraPageState();
}

class _AtualizarObraPageState extends State<AtualizarObraPage> {
  final _formKey = GlobalKey<FormState>();
  //
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  //
  final regexGeral = RegExp(r'^[a-zA-ZÀ-ÿ\s]{4,}$');

  @override
  void initState() {
    super.initState();

    _tituloController.text = widget.obra.title;
    _autorController.text = widget.obra.autor;
    _descricaoController.text = widget.obra.description;
  }
  
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
              "${widget.obra.title}",
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
                    "Titulo: ${widget.obra.title}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Autor: ${widget.obra.autor}",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  Text(
                    "Descrição: ${widget.obra.description}",
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
                      'Atualizar Obra',
                      style: TextStyle(
                      fontSize: 32,
                      ),
                    ),  
                    SizedBox(height: 16,),
                    SizedBox(
                      width: 900,
                      child: TextFormField(
                        controller: _tituloController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Titulo',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo Titulo';
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
                        controller: _autorController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Autor',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty){
                            if ((value.isNotEmpty) && (!regexGeral.hasMatch(value.trim()))) {
                              return 'Campo inválido. Apenas letras (min. 4 caracteres)';
                            }
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final title = _tituloController.text.trim();
                          final autor = _autorController.text.trim();
                          final descricao = _descricaoController.text.trim();

                          final resultado = await atualizarObraFunction(title: title, description: descricao, autor: autor, id: widget.obra.id);

                          if (resultado == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Obra atualizada com sucesso'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            Future.delayed(
                              Duration(seconds: 2),
                              () {
                                Navigator.pop(context, true);
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Falha ao atualizar obra"),
                                duration: Duration(seconds: 2),
                              )
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Falha no formulário"),
                                duration: Duration(seconds: 2),
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