import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: QuizApp()));
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Map<String, dynamic>> perguntas = [
    {
      "q": "Qual é o planeta mais próximo do Sol?",
      "a": ["Vênus", "Mercúrio", "Marte", "Terra"],
      "c": 1
    },
    {
      "q": "Quem pintou a Mona Lisa?",
      "a": ["Da Vinci", "Michelangelo", "Van Gogh", "Picasso"],
      "c": 0
    },
    {
      "q": "Qual é o maior oceano do mundo?",
      "a": ["Atlântico", "Índico", "Pacífico", "Ártico"],
      "c": 2
    },
    {
      "q": "Em que continente fica o Egito?",
      "a": ["África", "Ásia", "Europa", "América"],
      "c": 0
    },
    {
      "q": "Qual é o idioma mais falado do mundo?",
      "a": ["Espanhol", "Inglês", "Chinês", "Hindi"],
      "c": 2
    },
    {
      "q": "Qual é o maior país do mundo?",
      "a": ["Brasil", "China", "Canadá", "Rússia"],
      "c": 3
    },
    {
      "q": "Qual é o menor país do mundo?",
      "a": ["Mônaco", "Vaticano", "Malta", "San Marino"],
      "c": 1
    },
    {
      "q": "Qual é o animal mais rápido do mundo?",
      "a": ["Falcão-peregrino", "Guepardo", "Antílope", "Leopardo"],
      "c": 0
    },
    {
      "q": "Quem chegou no Brasil em 1500 e iniciou o processo de colonização?",
      "a": [
        "Pedro Álvares Cabral",
        "Cristóvão Colombo",
        "Vasco da Gama",
        "Dom Pedro I"
      ],
      "c": 0
    },
    {
      "q": "Qual é a capital do Japão?",
      "a": ["Tóquio", "Osaka", "Kyoto", "Hiroshima"],
      "c": 0
    }
  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    carregarEstado();
  }

  carregarEstado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      index = prefs.getInt("quiz_index") ?? 0;
      score = prefs.getInt("quiz_score") ?? 0;
    });
  }

  salvarEstado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("quiz_index", index);
    prefs.setInt("quiz_score", score);
  }

  responder(int i) {
    if (i == perguntas[index]["c"]) {
      score++;
    }

    index++;

    salvarEstado();

    if (index >= perguntas.length) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Resultado(score),
        ),
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (index >= perguntas.length) {
      return Resultado(score);
    }

    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              perguntas[index]["q"],
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            ...List.generate(
              4,
              (i) => ElevatedButton(
                onPressed: () => responder(i),
                child: Text(perguntas[index]["a"][i]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Resultado extends StatelessWidget {
  final int score;
  Resultado(this.score);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resultado")),
      body: Center(
        child: Text(
          "Pontuação: $score de 10",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
