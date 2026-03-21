import 'package:acervus_app/functions/obra/buscar_obra_function.dart';
import 'package:acervus_app/functions/obra/buscar_obras_function.dart';
import 'package:acervus_app/functions/obra/cadastrar_obra_function.dart';
import 'package:acervus_app/models/obra_model.dart';
import 'package:acervus_app/pages/atracao/atualizar_atracao_page.dart';
import 'package:acervus_app/pages/obra/atualizar_obra_page.dart';
import 'package:acervus_app/pages/obra/buscar_obra_page.dart';
import 'package:acervus_app/pages/obra/cadastrar_obra_page.dart';
import 'package:flutter/material.dart';
import 'package:acervus_app/home.dart';
import 'package:acervus_app/models/atracao_model.dart';
import 'package:acervus_app/pages/atracao/buscar_atracao_page.dart';
import 'package:acervus_app/pages/atracao/cadastrar_atracao_page.dart';
import 'package:acervus_app/functions/obra/buscar_obra_function.dart';
import 'package:acervus_app/functions/obra/deletar_obra_function.dart';
import 'package:acervus_app/functions/obra/buscar_obras_function.dart';

class ObrasPage extends StatefulWidget {
  const ObrasPage({super.key});

  @override
  State<ObrasPage> createState() => _ObrasPageState();
}

class _ObrasPageState extends State<ObrasPage> {
  late Future<List<ObraModel>> futureObras;

  @override
  void initState() {
    super.initState();
    futureObras = buscarObrasFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Obras',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder(
        future: futureObras, 
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

          final obras = snapshot.data!;

          return ListView.builder(
            itemCount: obras.length + 1,
            itemBuilder: (context, index) {
              if (index == obras.length) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(46.0),
                    child: SizedBox(
                      width: 265,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          final resultado = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadastrarObraPage()));

                          if (resultado == true) {
                            setState(() {
                              futureObras = buscarObrasFunction();
                            });
                          }
                        },
                        child: Text('Cadastrar Obra',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              final obra = obras[index];

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
                      "Titulo: ${obra.title}",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Autor: ${obra.autor}",
                          style: TextStyle(
                            fontSize: 21
                          ),
                        ),
                        Text(
                          "Descrição: ${obra.description}",
                          style: TextStyle(
                            fontSize: 21
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuscarObraPage(obra: obra)));
                          }, 
                        ),
                        SizedBox(width: 10,),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            final deletado = await deletarObraFunction(obra.id);

                            if (deletado == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Sucesso ao deletar obra"),
                                  duration: Duration(seconds: 2),
                                )
                              );

                              Future.delayed(
                                Duration(seconds: 2),
                                () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ObrasPage()));
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Falha ao deletar obra"),
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
                            final resultado = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AtualizarObraPage(obra: obra)));

                            if (resultado == true) {
                              setState(() {
                                futureObras = buscarObrasFunction();
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
      ),
    );
  }
}