import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: PrimeiraPagina()),
  );
}

class PrimeiraPagina extends StatelessWidget {
  const PrimeiraPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: const Text('Aves'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Container(
          color: Colors.lightBlue,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Coruja buraqueira\n"),
              Image.network(
                'https://agron.com.br/wp-content/uploads/2025/05/Como-a-coruja-buraqueira-vive-em-grupo-2.webp',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SegundaPagina(),
                    ),
                  );
                },
                child: const Text('Rolinha-do-planalto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SegundaPagina extends StatelessWidget {
  const SegundaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: const Text('Hello'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Container(
          color: Colors.lightBlue,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Rolinha-do-planalto\n"),
              Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvWgAR0SQJWS2WwSJdz6FNP19rrTDZ-MbPgA&s',
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Coruja buraqueira'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
