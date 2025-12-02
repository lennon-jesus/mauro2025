import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  double? temperatura;
  double? umidade;
  double? vento;

  double? latitude;
  double? longitude;

  bool carregando = true;

  @override
  void initState() {
    super.initState();
    obterDados();
  }

  Future<void> obterDados() async {
    await pegarLocalizacao();
    await pegarClima();
    setState(() => carregando = false);
  }

  Future<void> pegarLocalizacao() async {
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = pos.latitude;
    longitude = pos.longitude;
  }

  Future<void> pegarClima() async {
    final url =
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m,wind_speed_10m";

    final resposta = await http.get(Uri.parse(url));

    if (resposta.statusCode == 200) {
      final dados = json.decode(resposta.body);

      temperatura = dados["current"]["temperature_2m"]?.toDouble();
      umidade = dados["current"]["relative_humidity_2m"]?.toDouble();
      vento = dados["current"]["wind_speed_10m"]?.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Clima Atual")),
        body: Center(
          child: carregando
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Latitude: $latitude"),
                    Text("Longitude: $longitude"),
                    const SizedBox(height: 20),
                    Text("Temperatura: ${temperatura ?? '--'} °C",
                        style: const TextStyle(fontSize: 20)),
                    Text("Umidade: ${umidade ?? '--'} %", 
                        style: const TextStyle(fontSize: 20)),
                    Text("Vento: ${vento ?? '--'} km/h",
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => carregando = true);
                        obterDados();
                      },
                      child: const Text("Atualizar"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
