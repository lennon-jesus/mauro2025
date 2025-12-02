import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController cityController = TextEditingController();

  double? temperatura;
  double? umidade;
  double? vento;

  bool carregando = false;

  Future<void> buscarClima() async {
    setState(() => carregando = true);

    final cidade = cityController.text.trim();
    if (cidade.isEmpty) return;

    final geoUrl =
        "https://geocoding-api.open-meteo.com/v1/search?name=$cidade&count=1&language=pt&format=json";

    final geoResp = await http.get(Uri.parse(geoUrl));
    final geoData = json.decode(geoResp.body);

    if (geoData["results"] == null) {
      setState(() => carregando = false);
      return;
    }

    final lat = geoData["results"][0]["latitude"];
    final lon = geoData["results"][0]["longitude"];

    // 2. Buscar clima
    final climaUrl =
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,wind_speed_10m";

    final climaResp = await http.get(Uri.parse(climaUrl));
    final climaData = json.decode(climaResp.body);

    setState(() {
      temperatura = climaData["current"]["temperature_2m"];
      umidade = climaData["current"]["relative_humidity_2m"];
      vento = climaData["current"]["wind_speed_10m"];
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Clima por Cidade")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: "Digite a cidade",
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: buscarClima,
                child: const Text("Buscar"),
              ),
              const SizedBox(height: 20),
              if (carregando) const CircularProgressIndicator(),
              if (!carregando && temperatura != null)
                Column(
                  children: [
                    Text("Temperatura: $temperatura °C",
                        style: const TextStyle(fontSize: 18)),
                    Text("Umidade: $umidade %", style: const TextStyle(fontSize: 18)),
                    Text("Vento: $vento km/h", style: const TextStyle(fontSize: 18)),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
