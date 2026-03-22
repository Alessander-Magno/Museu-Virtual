import 'package:flutter/material.dart';
import 'package:acervus_app/models/atracao_model.dart';
import 'package:acervus_app/pages/atracao/buscar_atracao_page.dart';
import 'package:acervus_app/pages/atracao/cadastrar_atracao_page.dart';
import 'package:acervus_app/pages/atracao/atualizar_atracao_page.dart';
import 'package:acervus_app/functions/atracao/deletar_atracao_function.dart';
import 'package:acervus_app/functions/atracao/buscar_atracoes_function.dart';

class AtracoesPage extends StatefulWidget {
  const AtracoesPage({super.key});

  @override
  State<AtracoesPage> createState() => _AtracoesPageState();
}

class _AtracoesPageState extends State<AtracoesPage> {
  late Future<List<AtracaoModel>> futureAtracoes;

  @override
  void initState() {
    super.initState();
    futureAtracoes = buscarAtracoesFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atrações',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder(
        future: futureAtracoes, 
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
                  fontSize: 25,
                ),
              )
            );
          }

          final atracoes = snapshot.data!;

          if (atracoes.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(46.0),
                child: Column(
                  children: [
                    Text(
                      "Sem atrações cadastradas no momento",
                      style: TextStyle(
                        fontFamily: 'Playfair',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      width: 265,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          final resultado = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadastrarAtracaoPage()));
                    
                          if (resultado == true) {
                            setState(() {
                              futureAtracoes = buscarAtracoesFunction();
                            });
                          }
                        },
                        child: Text('Cadastrar Atração',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: atracoes.length + 1,
              itemBuilder: (context, index) {
                if (index == atracoes.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(46.0),
                      child: SizedBox(
                        width: 265,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            final resultado = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadastrarAtracaoPage()));

                            if (resultado == true) {
                              setState(() {
                                futureAtracoes = buscarAtracoesFunction();
                              });
                            }
                          },
                          child: Text('Cadastrar Atração',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                final atracao = atracoes[index];

                return Center(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    width: 700,
                    child: ListTile(
                      title: Text(
                        "Nome: ${atracao.nome}",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Descrição: ${atracao.description}",
                            style: TextStyle(
                              fontSize: 21
                            ),
                          ),
                          Text("Disponibilidade: ${(atracao.disponibilidade) ? "sim" : "não"}",
                            style: TextStyle(
                              fontSize: 21
                            ),
                          )
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuscarAtracaoPage(id: atracao.id)));
                            }, 
                          ),
                          SizedBox(width: 10,),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              final deletado = await deletarAtracaoFunction(atracao.id);

                              if (deletado) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Sucesso ao deletar atração"),
                                    duration: Duration(seconds: 2),
                                  )
                                );

                                Future.delayed(
                                  Duration(seconds: 2),
                                  () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AtracoesPage()));
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Falha ao deletar atração"),
                                    duration: Duration(seconds: 2),
                                  )
                                );
                              }
                            }, 
                          ),
                          SizedBox(width: 10,),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              final resultado = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AtualizarAtracaoPage(atracao: atracao)));

                              if (resultado == true) {
                                setState(() {
                                  futureAtracoes = buscarAtracoesFunction();
                                });
                              }
                            }, 
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }
      ),
    );
  }
}