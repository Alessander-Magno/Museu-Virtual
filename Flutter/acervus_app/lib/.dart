// import 'package:acervus_app/functions/atracao/buscar_atracao_function.dart';
// import 'package:acervus_app/models/atracao_model.dart';
// import 'package:acervus_app/models/obra_model.dart';
// import 'package:flutter/material.dart';

// class BuscarAtracaoPage extends StatefulWidget {
//   final String id;

//   BuscarAtracaoPage({super.key, required this.id});

//   @override
//   State<BuscarAtracaoPage> createState() => _BuscarAtracaoPageState();
// }

// class _BuscarAtracaoPageState extends State<BuscarAtracaoPage> {
//   AtracaoModel? atracao;

//   @override
//   void initState() {
//     super.initState();
//     carregarAtracao(widget.id) ;
//   }

//   @override
//   Widget build(BuildContext context) {

//     if (atracao == null) {
//       return Center(
//         child: CircularProgressIndicator()
//       );
//     }

//     final obras = atracao!.obras;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Buscar',
//           style: TextStyle(
//             fontSize: 25,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text(
//               atracao!.nome,
//               style: TextStyle(
//                 fontSize: 62,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(20),
//               padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 1
//                 ),
//                 borderRadius: BorderRadius.circular(16)
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "ID: ${atracao!.id}",
//                     style: TextStyle(
//                       fontSize: 25,
//                     ),
//                   ),
//                   Text(
//                     "Nome: ${atracao!.nome}",
//                     style: TextStyle(
//                       fontSize: 25,
//                     ),
//                   ),
//                   Text(
//                     "Descrição: ${atracao!.description}",
//                     style: TextStyle(
//                       fontSize: 25
//                     ),
//                   ),
//                   Text("Disponibilidade: ${(atracao!.disponibilidade) ? "sim" : "não"}",
//                     style: TextStyle(
//                       fontSize: 25
//                     ),
//                   ),
//                   Text("Quantidade de obras: ${atracao!.obras.length}",
//                     style: TextStyle(
//                       fontSize: 25
//                     ),
//                   ),
//                 ]  
//               ),
//             ),
//             ListView.builder(
//               itemCount: obras.length,
//               itemBuilder: (context, index) {
//                 if (obras.isEmpty) {
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(46.0),
//                       child: SizedBox(
//                         width: 60,
//                         height: 60,
//                         child: Text("Sem obras vinculadas"),
//                       ),
//                     ),
//                   );
//                 }
            
//                 final obra = obras[index];
            
//                 return Center(
//                   child: Container(
//                     margin: EdgeInsets.all(8),
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                         width: 1
//                       ),
//                       borderRadius: BorderRadius.circular(16)
//                     ),
//                     width: 700,
//                     child: ListTile(
//                       title: Text(
//                         "Titulo: ${obra.title}",
//                         style: TextStyle(
//                           fontSize: 25,
//                         ),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Descrição: ${obra.description}",
//                             style: TextStyle(
//                               fontSize: 21
//                             ),
//                           ),
//                           Text(
//                             "Autor: ${obra.autor}",
//                             style: TextStyle(
//                               fontSize: 21
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> carregarAtracao(String id) async {
//     try {
//       final dado = await buscarAtracaoFunction(id);

//       setState(() {
//         atracao = dado;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
// }