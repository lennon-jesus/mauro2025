import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: BirthScreen()));
}

class BirthScreen extends StatefulWidget {
  @override
  _BirthScreenState createState() => _BirthScreenState();
}

class _BirthScreenState extends State<BirthScreen> {
  DateTime? nascimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data de Nascimento")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Selecionar Data"),
              onPressed: () async {
                nascimento = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (nascimento != null) {
                  int idade = DateTime.now().year - nascimento!.year;
                  if (DateTime.now().month < nascimento!.month ||
                      (DateTime.now().month == nascimento!.month &&
                          DateTime.now().day < nascimento!.day)) {
                    idade--;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IdadeScreen(idade),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class IdadeScreen extends StatelessWidget {
  final int idade;
  IdadeScreen(this.idade);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Idade")),
      body: Center(
        child: Text(
          "Idade: $idade anos",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
