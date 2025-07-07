import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const Custa1RealApp());
}

class Custa1RealApp extends StatelessWidget {
  const Custa1RealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custa 1 Real',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool modoZen = false;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }

  void ativarModoZen() async {
    setState(() {
      modoZen = true;
    });
    final bytes = await rootBundle.load('assets/rain.mp3');
    final sound = bytes.buffer.asUint8List();
    await player.play(BytesSource(sound), volume: 0.7);
  }

  Future<void> gerarCertificado() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Parabéns!
Você usou o app mais inútil do mundo.',
              style: pw.TextStyle(fontSize: 24)),
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/certificado.pdf");
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Certificado gerado com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custa 1 Real')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Este app custa 1 real e só faz isso.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ativarModoZen,
              child: const Text('Ativar modo Zen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: gerarCertificado,
              child: const Text('Gerar certificado inútil'),
            ),
          ],
        ),
      ),
    );
  }
}

class AudioPlayer {
  dynamic _player;
  Future<void> play(BytesSource src, {double volume = 1.0}) async {
    // Simulação de player — substitua por audioplayers se for compilar local
  }

  void stop() {
    // Simulação
  }
}

class BytesSource {
  final List<int> data;
  BytesSource(this.data);
}
