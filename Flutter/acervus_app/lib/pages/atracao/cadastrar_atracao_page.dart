import 'package:acervus_app/functions/atracao/cadastrar_atracao_function.dart';
import 'package:flutter/material.dart';
import 'package:acervus_app/models/atracao_model.dart';
import 'package:acervus_app/pages/atracao/atracoes_page.dart';
import 'package:acervus_app/functions/atracao/atualizar_atracao_function.dart';

class CadastrarAtracaoPage extends StatefulWidget {
  CadastrarAtracaoPage({super.key});

  @override
  State<CadastrarAtracaoPage> createState() => _CadastrarAtracaoPageState();
}

class _CadastrarAtracaoPageState extends State<CadastrarAtracaoPage> {
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
                      'Cadastrar Atração',
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

                          cadastrarAtracaoFunction(nome, descricao);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Atração cadastrada com sucesso'),
                              duration: Duration(seconds: 3),
                            ),
                          );

                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Falha ao cadastrada atração"),
                              duration: Duration(seconds: 3),
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
