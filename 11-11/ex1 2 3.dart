import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MainApp());
}

class Localizacao {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> pegaLocalizacaoAtual() async {

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = pos.latitude;
    longitude = pos.longitude;
  }
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Localizacao loc = Localizacao();

  @override
  void initState() {
    super.initState();
    atualizarLocalizacao();
  }

  Future<void> atualizarLocalizacao() async {
    await loc.pegaLocalizacaoAtual();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Busca Local', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 20),
              Text('Latitude: ${loc.latitude}'),
              Text('Longitude: ${loc.longitude}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: atualizarLocalizacao,
                child: const Text("Atualizar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
