import 'package:acervus_app/functions/obra/buscar_obras_function.dart';
import 'package:acervus_app/models/obra_model.dart';
import 'package:acervus_app/pages/obra/atualizar_obra_page.dart';
import 'package:acervus_app/pages/obra/buscar_obra_page.dart';
import 'package:acervus_app/pages/obra/cadastrar_obra_page.dart';
import 'package:flutter/material.dart';
import 'package:acervus_app/functions/obra/deletar_obra_function.dart';

class ObrasPage extends StatefulWidget {
  const ObrasPage({super.key});

  @override
  State<ObrasPage> createState() => _ObrasPageState();
}

class _ObrasPageState extends State<ObrasPage> {
  late Future<List<ObraModel>> futureObras;
  // 
  List<ObraModel> obrasCompletas = [];
  List<ObraModel> obrasFiltradas = [];
  //
  TextEditingController buscaController = TextEditingController();


  @override
  void initState() {
    super.initState();
    futureObras = buscarObrasFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (TextFormField(
            controller: buscaController,
            decoration: InputDecoration(
              hintText: 'Buscar por obras',
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
                    obrasFiltradas = obrasCompletas;
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

          if (obrasCompletas.isEmpty) {
            obrasCompletas = snapshot.data!;
            obrasFiltradas = obrasCompletas;
          }

          if (obrasFiltradas.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(46.0),
                child: Column(
                  children: [
                    Text(
                     (obrasCompletas.isEmpty ? "Sem obras cadastradas no momento" : "Nenhuma obras cadastrada com esse nome"),
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
                          final resultado = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadastrarObraPage()));
                    
                          if (resultado == true) {
                            final novasObras = await buscarObrasFunction();

                            setState(() {
                              obrasCompletas = novasObras;
                              obrasFiltradas = obrasCompletas;
                              buscaController.clear();
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
                  ],
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: obrasFiltradas.length + 1,
              itemBuilder: (context, index) {
                if (index == obrasFiltradas.length) {
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
                              final novasObras = await buscarObrasFunction();

                              setState(() {
                                obrasCompletas = novasObras;
                                obrasFiltradas = obrasCompletas;
                                buscaController.clear();
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

                final obra = obrasFiltradas[index];

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
                                final novasObras = await buscarObrasFunction();

                                setState(() {
                                  obrasCompletas = novasObras;
                                  obrasFiltradas = obrasCompletas;
                                  buscaController.clear();
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
        obrasFiltradas = obrasCompletas.where(
          (obra) =>
          obra.title.toLowerCase().contains(texto)
        ).toList();
      });
  }
}