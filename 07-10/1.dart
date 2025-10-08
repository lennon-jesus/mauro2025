import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const double alturaContainer = 80.0;
const Color fundo = Color(0xFF1E164B);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double altura = 1.50;
  int peso = 65;
  double imc = 0.0;
  String genero = '';

  void calcularIMC() {
    setState(() {
      imc = peso / (altura * altura);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('IMC')),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => genero = 'MASC'),
                      child: Caixa(
                        cor: genero == 'MASC' ? Colors.blue : fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.male,
                              color: Colors.white,
                              size: 80.0,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'MASC',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => genero = 'FEM'),
                      child: Caixa(
                        cor: genero == 'FEM' ? Colors.pinkAccent : fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.female,
                              color: Colors.white,
                              size: 80.0,
                            ),
                            SizedBox(height: 15),
                            Text(
                              'FEM',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ALTURA
            Expanded(
              child: Caixa(
                cor: fundo,
                filho: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Altura (m)',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      altura.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    Slider(
                      value: altura,
                      min: 1.0,
                      max: 2.5,
                      divisions: 150,
                      onChanged: (double novoValor) {
                        setState(() {
                          altura = novoValor;
                          calcularIMC();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Caixa(
                      cor: fundo,
                      filho: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Peso (kg)',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '$peso',
                            style: const TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    peso++;
                                    calcularIMC();
                                  });
                                },
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (peso > 1) peso--;
                                    calcularIMC();
                                  });
                                },
                                icon: const Icon(Icons.remove),
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Caixa(
                      cor: fundo,
                      filho: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Resultado:',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            imc == 0.0 ? '--' : imc.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: calcularIMC,
              child: Container(
                color: const Color(0xFF638ED6),
                width: double.infinity,
                height: alturaContainer,
                margin: const EdgeInsets.only(top: 10.0),
                child: const Center(
                  child: Text(
                    'CALCULAR IMC',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Caixa extends StatelessWidget {
  final Color cor;
  final Widget? filho;

  const Caixa({super.key, required this.cor, this.filho});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cor,
      ),
      child: filho,
    );
  }
}
