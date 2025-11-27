import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

Card flashcard(
  String frase,
  String traducao,
  String imagem,
  IconData icone,
  Color cor,
  int r,
  int g,
  int b,
) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    color: Color.fromARGB(255, r, g, b),
    child: Column(
      children: [
        SizedBox(
          height: 150,
          child: Image.network(imagem, fit: BoxFit.cover),
        ),
        ListTile(
          leading: Icon(icone, size: 40, color: cor),
          title: Text(frase, style: GoogleFonts.rampartOne(fontSize: 18)),
          subtitle: Text(traducao, style: GoogleFonts.quicksand(fontSize: 14)),
        ),
        TextButton(
          child: Text("Memorizado"),
          onPressed: () {

          },
        )
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              flashcard(
                "I ate an apple.",
                "Eu comi uma maçã.",
                "https://images.unsplash.com/photo-1567306226416-28f0efdc88ce",
                Icons.history,
                Colors.brown,
                220,
                190,
                140,
              ),
              SizedBox(
                height: 2,
                width: 200,
                child: Divider(color: Colors.orange),
              ),
              flashcard(
                "I eat an apple.",
                "Eu como uma maçã.",
                "https://images.unsplash.com/photo-1567306226416-28f0efdc88ce",
                Icons.wb_sunny,
                Colors.orange,
                255,
                230,
                150,
              ),
              SizedBox(
                height: 2,
                width: 200,
                child: Divider(color: Colors.orange),
              ),
              flashcard(
                "I will eat an apple.",
                "Eu comerei uma maçã.",
                "https://images.unsplash.com/photo-1567306226416-28f0efdc88ce",
                Icons.event,
                Colors.blue,
                170,
                210,
                255,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
