import 'package:acervus_app/pages/obra/obras_page.dart';
import 'package:flutter/material.dart';
import 'package:acervus_app/pages/atracao/atracoes_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                "Museu Virtual",
                style: TextStyle(
                  fontFamily: 'Playfair',
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
            Row(
              mainAxisSize: MainAxisSize.min,
              
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AtracoesPage(),));
                  }, 
                  label: Text('Atrações', style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  icon: Icon(Icons.theater_comedy, size: 22,),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                  )
                ), 
                SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ObrasPage()));
                  }, 
                  label: Text('Obras', style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  icon: Icon(Icons.image, size: 22,),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}