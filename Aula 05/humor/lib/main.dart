import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HumorApp(),
  ));
}

class HumorApp extends StatefulWidget {
  @override
  _HumorAppState createState() => _HumorAppState();
}

class _HumorAppState extends State<HumorApp> {
  // 0 = Feliz, 1 = Neutro, 2 = Bravo
  int estadoAtual = 0;

  void mudarHumor() {
    setState(() {
      estadoAtual = (estadoAtual + 1) % 3;
    });
  }

  String obterTexto() {
    if (estadoAtual == 0) return "Felizz!";
    if (estadoAtual == 1) return "Neutro";
    return "Bravooo";
  }

  IconData obterIcone() {
    if (estadoAtual == 0) return Icons.sentiment_very_satisfied;
    if (estadoAtual == 1) return Icons.sentiment_neutral;
    return Icons.sentiment_very_dissatisfied;
  }

  Color obterCor() {
    if (estadoAtual == 0) return Colors.green;
    if (estadoAtual == 1) return Colors.grey;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AQUI: O fundo agora recebe a cor do sentimento
      backgroundColor: obterCor(), 
      appBar: AppBar(
        title: Text("Botão de Humor"),
        centerTitle: true,
        // Elevation 0 para o AppBar "sumir" no fundo
        elevation: 0, 
        backgroundColor: obterCor(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              obterIcone(),
              size: 120,
              // Mudado para branco para destacar no fundo colorido
              color: Colors.white, 
            ),
            SizedBox(height: 20),
            Text(
              obterTexto(),
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Colors.white, // Mudado para branco
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: mudarHumor,
              style: ElevatedButton.styleFrom(
                // Botão branco com texto na cor do sentimento
                backgroundColor: Colors.white, 
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Mudar Humor",
                style: TextStyle(
                  color: obterCor(), // Texto do botão na cor do humor
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}