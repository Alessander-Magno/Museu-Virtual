import 'package:flutter/material.dart';
import 'package:acervus_app/models/obra_model.dart';
import 'package:acervus_app/pages/obra/buscar_obra_page.dart';
import 'package:acervus_app/functions/obra/buscar_obras_function.dart';

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
                  ],
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: obrasFiltradas.length,
              itemBuilder: (context, index) {

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