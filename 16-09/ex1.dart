import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: RaioScreen()));
}

class RaioScreen extends StatelessWidget {
  final TextEditingController raioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digite o raio')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: raioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Raio"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double r = double.parse(raioController.text);
                double area = pi * r * r;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultadoScreen(area),
                  ),
                );
              },
              child: Text("Calcular área"),
            )
          ],
        ),
      ),
    );
  }
}

class ResultadoScreen extends StatelessWidget {
  final double area;

  ResultadoScreen(this.area);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Área do círculo')),
      body: Center(
        child: Text(
          "Área: ${area.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
