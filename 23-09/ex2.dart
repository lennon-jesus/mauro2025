import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: TabuadaApp()));
}

class TabuadaApp extends StatefulWidget {
  @override
  _TabuadaAppState createState() => _TabuadaAppState();
}

class _TabuadaAppState extends State<TabuadaApp> {
  int n = 1;
  int valor1 = 1;
  int valor2 = 1;
  TextEditingController resposta = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregar();
    gerarConta();
  }

  carregar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      n = prefs.getInt("tabuada_n") ?? 1;
    });
  }

  salvar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("tabuada_n", n);
  }

  gerarConta() {
    valor1 = n;
    valor2 = Random().nextInt(10) + 1;
  }

  verificar() {
    int? r = int.tryParse(resposta.text);
    if (r == valor1 * valor2) {
      n++;
      if (n > 10) n = 1;
      salvar();
      gerarConta();
      resposta.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tabuada")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "$valor1 x $valor2 = ?",
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: resposta,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: verificar,
              child: Text("Responder"),
            ),
            SizedBox(height: 20),
            Text("Tabuada atual: $n")
          ],
        ),
      ),
    );
  }
}
