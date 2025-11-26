import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CadastroScreen()));
}

class CadastroScreen extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController matriculaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro do Aluno")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: matriculaController,
              decoration: InputDecoration(labelText: "Matrícula"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Próximo"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotasScreen(
                      nomeController.text,
                      matriculaController.text,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class NotasScreen extends StatefulWidget {
  final String nome;
  final String matricula;

  NotasScreen(this.nome, this.matricula);

  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final TextEditingController notaController = TextEditingController();
  List<double> notas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lançar Notas")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: notaController,
              decoration: InputDecoration(labelText: "Digite a nota"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("Adicionar Nota"),
              onPressed: () {
                setState(() {
                  double? n = double.tryParse(notaController.text);
                  if (n != null) notas.add(n);
                  notaController.clear();
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Ver Dados"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultadoScreen(
                      widget.nome,
                      widget.matricula,
                      notas,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ResultadoScreen extends StatelessWidget {
  final String nome;
  final String matricula;
  final List<double> notas;

  ResultadoScreen(this.nome, this.matricula, this.notas);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dados do Aluno")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: $nome", style: TextStyle(fontSize: 20)),
            Text("Matrícula: $matricula", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text("Notas:", style: TextStyle(fontSize: 22)),
            Expanded(
              child: ListView.builder(
                itemCount: notas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "Nota ${index + 1}: ${notas[index]}",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
