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
  //
  List<AtracaoModel> atracoesCompletas = [];
  List<AtracaoModel> atracoesFiltradas = [];
  //
  TextEditingController buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureAtracoes = buscarAtracoesFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (TextFormField(
            controller: buscaController,
            decoration: InputDecoration(
              hintText: 'Buscar por atrações',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: IconButton(
              onPressed: 
              () {
                if (buscaController.text.isEmpty) {
                  setState(() {
                    atracoesFiltradas = atracoesCompletas;
                  });
                } else {
                  mudarEstadoUI(buscaController.text);
                }
              }, 
              icon: Icon(Icons.search),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<AtracaoModel>>(
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

          if (atracoesCompletas.isEmpty) {
            atracoesCompletas = snapshot.data!;
            atracoesFiltradas = atracoesCompletas;
          }

          if (atracoesFiltradas.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(46.0),
                child: Column(
                  children: [
                    Text( 
                      (atracoesCompletas.isEmpty ? "Sem atrações cadastradas no momento" : "Nenhuma atração cadastrada com esse nome"),
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
                            final novasAtracoes = await buscarAtracoesFunction();

                            setState(() {
                              atracoesCompletas = novasAtracoes;
                              atracoesFiltradas = atracoesCompletas;
                              buscaController.clear();
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
              itemCount: atracoesFiltradas.length + 1,
              itemBuilder: (context, index) {
                if (index == atracoesFiltradas.length) {
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

                final atracao = atracoesFiltradas[index];

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

  void mudarEstadoUI(String texto) {
    texto = texto.toLowerCase();
    
      setState(() {
        atracoesFiltradas = atracoesCompletas.where(
          (atracao) =>
          atracao.nome.toLowerCase().contains(texto.toLowerCase())
        ).toList();
      });
  }
}