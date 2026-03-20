import 'package:acervus_app/home.dart';
import 'package:flutter/material.dart';
import 'package:acervus_app/functions/obra/buscar_obras_function.dart';

class ObrasPage extends StatefulWidget {
  const ObrasPage({super.key});

  @override
  State<ObrasPage> createState() => _ObrasPageState();
}

class _ObrasPageState extends State<ObrasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Obras'),
      ),
      body: FutureBuilder(
        future: buscarObras(), 
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
                  fontSize: 22,
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
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Text('Cadastrar Obra'),
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
                        fontSize: 22,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Descrição: ${obra.description}",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                        Text("Autor: ${(obra.autor)}",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        )
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {}, 
                          icon: Icon(Icons.search)
                        ),
                        SizedBox(width: 10,),
                        IconButton(
                          onPressed: () {}, 
                          icon: Icon(Icons.delete)
                        ),
                        SizedBox(width: 10,),
                         IconButton(
                          onPressed: () {}, 
                          icon: Icon(Icons.edit)
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