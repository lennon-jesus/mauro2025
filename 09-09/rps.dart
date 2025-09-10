import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(JogoComImagens());
}

class JogoComImagens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedra Papel Tesoura',
      home: TelaJogo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TelaJogo extends StatefulWidget {
  @override
  _TelaJogoState createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  final List<String> opcoes = ["Pedra", "Papel", "Tesoura"];

  final List<String> imagens = [
    'https://t3.ftcdn.net/jpg/01/23/14/80/360_F_123148069_wkgBuIsIROXbyLVWq7YNhJWPcxlamPeZ.jpg',
    'https://i.ebayimg.com/00/s/MTIwMFgxNjAw/z/KAcAAOSwTw5bnTbW/\$_57.JPG',
    'https://t4.ftcdn.net/jpg/02/55/26/63/360_F_255266320_plc5wjJmfpqqKLh0WnJyLmjc6jFE9vfo.jpg',
  ];

  int? escolhaUsuario;
  int? escolhaMaquina;
  String resultado = "";
  int jogadas = 0;
  int vitoriasUsuario = 0;

  void jogar(int escolha) {
    setState(() {
      escolhaUsuario = escolha;
      jogadas++;

      escolhaMaquina = _escolhaMaquina(escolhaUsuario!);

      resultado = _verificarResultado(escolhaUsuario!, escolhaMaquina!);
    });
  }

  int _escolhaMaquina(int usuario) {
    Random random = Random();

    if (jogadas % 5 != 0 || vitoriasUsuario >= 1) {
      switch (usuario) {
        case 0:
          return random.nextBool() ? 1 : 0;
        case 1:
          return random.nextBool() ? 2 : 1;
        case 2:
          return random.nextBool() ? 0 : 2;
      }
    }

    vitoriasUsuario++;
    switch (usuario) {
      case 0:
        return 2;
      case 1:
        return 0;
      case 2:
        return 1;
    }

    return random.nextInt(3);
  }

  String _verificarResultado(int usuario, int maquina) {
    if (usuario == maquina) return "Empate!";

    if ((usuario == 0 && maquina == 2) ||
        (usuario == 1 && maquina == 0) ||
        (usuario == 2 && maquina == 1)) {
      return "Você ganhou!";
    } else {
      return "A máquina ganhou!";
    }
  }

  Widget _imagemEscolha(int? index) {
    if (index == null) return SizedBox.shrink();
    return Image.network(imagens[index], width: 100, height: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo: Pedra Papel Tesoura"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Escolha sua jogada:", style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(imagens.length, (index) {
                return GestureDetector(
                  onTap: () => jogar(index),
                  child: Image.network(imagens[index], width: 80, height: 80),
                );
              }),
            ),
            SizedBox(height: 30),
            if (escolhaUsuario != null && escolhaMaquina != null) ...[
              Text("Sua escolha:"),
              _imagemEscolha(escolhaUsuario),
              SizedBox(height: 10),
              Text("Escolha da máquina:"),
              _imagemEscolha(escolhaMaquina),
              SizedBox(height: 20),
              Text(
                resultado,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text("Jogadas: $jogadas | Vitórias suas: $vitoriasUsuario"),
            ]
          ],
        ),
      ),
    );
  }
}
