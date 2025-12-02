import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const CardGame());
}

class CardGame extends StatefulWidget {
  const CardGame({super.key});

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {
  String? playerCard;
  String? machineCard;

  int playerWins = 0;
  int machineWins = 0;

  final Map<String, int> values = {
    "ACE": 14,
    "KING": 13,
    "QUEEN": 12,
    "JACK": 11,
    "10": 10,
    "9": 9,
    "8": 8,
    "7": 7,
    "6": 6,
    "5": 5,
    "4": 4,
    "3": 3,
    "2": 2
  };

  Future<void> play() async {
    final url = "https://deckofcardsapi.com/api/deck/new/draw/?count=2";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    final c1 = data["cards"][0];
    final c2 = data["cards"][1];

    setState(() {
      playerCard = c1["image"];
      machineCard = c2["image"];
    });

    final v1 = values[c1["value"]]!;
    final v2 = values[c2["value"]]!;

    if (v1 > v2) {
      playerWins++;
    } else if (v2 > v1) {
      machineWins++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Jogo de Cartas")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Jogador: $playerWins   |   Máquina: $machineWins"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                machineCard == null
                    ? Container(width: 100, height: 150, color: Colors.grey)
                    : Image.network(machineCard!, width: 100, height: 150),
                playerCard == null
                    ? Container(width: 100, height: 150, color: Colors.grey)
                    : Image.network(playerCard!, width: 100, height: 150),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: play,
              child: const Text("Jogar"),
            )
          ],
        ),
      ),
    );
  }
}
