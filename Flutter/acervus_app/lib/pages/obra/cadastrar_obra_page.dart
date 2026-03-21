import 'package:acervus_app/functions/atracao/cadastrar_atracao_function.dart';
import 'package:acervus_app/functions/obra/cadastrar_obra_function.dart';
import 'package:flutter/material.dart';
import 'package:acervus_app/models/atracao_model.dart';
import 'package:acervus_app/pages/atracao/atracoes_page.dart';
import 'package:acervus_app/functions/atracao/atualizar_atracao_function.dart';

class CadastrarObraPage extends StatefulWidget {
  CadastrarObraPage({super.key});

  @override
  State<CadastrarObraPage> createState() => _CadastrarObraPageState();
}

class _CadastrarObraPageState extends State<CadastrarObraPage> {
  final _formKey = GlobalKey<FormState>();
  //
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _atracaoIdController = TextEditingController();
  //
  final regexGeral = RegExp(r'^[a-zA-ZÀ-ÿ\s]{4,}$');
  final regexAtracaoId = RegExp(r'^[a-zA-ZÀ-ÿ0-9\s-]{40,}$');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Cadastrar Obra',
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
                          labelText: 'Autor(opcional)',
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
                    SizedBox(
                      width: 900,
                      child: TextFormField(
                        controller: _atracaoIdController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'atracaoId',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo atracaoId';
                          }
                      
                          return null;
                        }
                      ),
                    ),
                    SizedBox(height: 16,),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final titulo = _tituloController.text.trim();
                          final autor = (_autorController.text.trim().isNotEmpty) ? _autorController.text.trim() : "desconhecido"; 
                          final descricao = _descricaoController.text.trim();
                          final atracaoId = _atracaoIdController.text.trim();

                          final resultado = await cadastrarObraFunction(title: titulo, description: descricao, autor: autor, atracaoId: atracaoId);

                          if (resultado == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Obra cadastrada com sucesso'),
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
                                content: Text("Falha ao cadastrar obra"),
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
                          child: Text('Cadastrar',
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
