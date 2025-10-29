import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatefulWidget {
  @override
  _CalculadoraAppState createState() => _CalculadoraAppState();
}

class _CalculadoraAppState extends State<CalculadoraApp> {
  String operador1 = '';
  String operador2 = '';
  String resultado = '';
  bool somaApertada = false;
  bool subtracaoApertada = false;
  bool multiplicacaoApertada = false;
  bool divisaoApertada = false;
  double memoria = 0.0;
  Database? database;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'calculadora.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE dados(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            numeroAtual TEXT,
            memoria REAL
          );
        ''');

        await db.execute('''
          CREATE TABLE operacoes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            operacao TEXT
          );
        ''');
      },
    );
  }

  Future<void> inserirDados(String numeroAtual, double memoria) async {
    await database?.insert('dados', {
      'numeroAtual': numeroAtual,
      'memoria': memoria,
    });
  }

  Future<void> inserirOperacao(String operacao) async {
    await database?.insert('operacoes', {'operacao': operacao});
  }

  Future<List<Map<String, dynamic>>> obterOperacoes() async {
    return await database?.query('operacoes') ?? [];
  }

  void pressionarBotao(String valor) {
    setState(() {
      if (valor == '+') {
        somaApertada = true;
        subtracaoApertada = multiplicacaoApertada = divisaoApertada = false;
      } else if (valor == '-') {
        subtracaoApertada = true;
        somaApertada = multiplicacaoApertada = divisaoApertada = false;
      } else if (valor == '*') {
        multiplicacaoApertada = true;
        somaApertada = subtracaoApertada = divisaoApertada = false;
      } else if (valor == '/') {
        divisaoApertada = true;
        somaApertada = subtracaoApertada = multiplicacaoApertada = false;
      } else if (valor == '=') {
        if (operador1.isNotEmpty && operador2.isNotEmpty) {
          double num1 = double.tryParse(operador1) ?? 0.0;
          double num2 = double.tryParse(operador2) ?? 0.0;
          double res = 0;

          if (somaApertada)
            res = num1 + num2;
          else if (subtracaoApertada)
            res = num1 - num2;
          else if (multiplicacaoApertada)
            res = num1 * num2;
          else if (divisaoApertada) {
            if (num2 != 0)
              res = num1 / num2;
            else {
              resultado = 'Erro (÷0)';
              return;
            }
          }

          resultado = res.toString();
          inserirOperacao(
              '$operador1 ${_getOperador()} $operador2 = $resultado');
          operador1 = resultado;
          operador2 = '';
          somaApertada = subtracaoApertada =
              multiplicacaoApertada = divisaoApertada = false;
        }
      } else if (valor == 'MC') {
        memoria = 0.0;
      } else if (valor == 'MR') {
        operador1 = memoria.toString();
      } else if (valor == 'M+') {
        memoria += double.tryParse(operador1) ?? 0.0;
      } else if (valor == 'M-') {
        memoria -= double.tryParse(operador1) ?? 0.0;
      } else if (valor == 'C') {
        operador1 = '0';
      } else {
        if (somaApertada ||
            subtracaoApertada ||
            multiplicacaoApertada ||
            divisaoApertada) {
          operador2 += valor;
        } else {
          operador1 += valor;
        }
      }
    });

    inserirDados(operador1, memoria);
  }

  String _getOperador() {
    if (somaApertada) return '+';
    if (subtracaoApertada) return '-';
    if (multiplicacaoApertada) return '*';
    if (divisaoApertada) return '/';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          primary: Colors.purple,
          secondary: Colors.deepPurpleAccent,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora Flutter'),
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () async {
                List<Map<String, dynamic>> operacoes = await obterOperacoes();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaHistorico(operacoes: operacoes),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Operador 1: $operador1',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Operador 2: $operador2',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Resultado: $resultado',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Memória: $memoria',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Linhas de botões
              buildLinha(['7', '8', '9', '/']),
              buildLinha(['4', '5', '6', '*']),
              buildLinha(['1', '2', '3', '-']),
              buildLinha(['0', 'MC', 'MR', '+']),
              buildLinha(['M+', 'M-', '=', 'C']),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLinha(List<String> valores) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: valores.map((v) => buildBotao(v)).toList(),
      ),
    );
  }

  Widget buildBotao(String valor) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 70,
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => pressionarBotao(valor),
          child: Text(
            valor,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class TelaHistorico extends StatelessWidget {
  final List<Map<String, dynamic>> operacoes;

  const TelaHistorico({required this.operacoes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Operações'),
      ),
      body: operacoes.isEmpty
          ? const Center(child: Text('Nenhuma operação registrada.'))
          : ListView.builder(
              itemCount: operacoes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(operacoes[index]['operacao'] ?? ''),
                );
              },
            ),
    );
  }
}
