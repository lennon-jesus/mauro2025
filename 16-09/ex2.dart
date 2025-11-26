import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: TabsCircle()));
}

class TabsCircle extends StatefulWidget {
  @override
  _TabsCircleState createState() => _TabsCircleState();
}

class _TabsCircleState extends State<TabsCircle> {
  double raio = 0;

  @override
  Widget build(BuildContext context) {
    double diametro = raio * 2;
    double circ = 2 * pi * raio;
    double area = pi * raio * raio;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Círculo"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Raio"),
              Tab(text: "Diâmetro"),
              Tab(text: "Circ."),
              Tab(text: "Área"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Digite o raio"),
                onChanged: (v) {
                  setState(() {
                    raio = double.tryParse(v) ?? 0;
                  });
                },
              ),
            ),
            Center(child: Text("Diâmetro: $diametro")),
            Center(child: Text("Circunferência: ${circ.toStringAsFixed(2)}")),
            Center(child: Text("Área: ${area.toStringAsFixed(2)}")),
          ],
        ),
      ),
    );
  }
}
