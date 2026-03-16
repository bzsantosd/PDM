import 'package:flutter/material.dart';
import 'dart:math'; // PASSO 2: Biblioteca para gerar números aleatórios

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: JogoApp(), // PASSO 1: Chamada da classe principal
  ));
}

// PASSO 1: Herança de StatefulWidget para permitir mudança de estado
class JogoApp extends StatefulWidget {
  @override
  _JogoAppState createState() => _JogoAppState();
}

class _JogoAppState extends State<JogoApp> {
  // PASSO 3: Inicialização das variáveis
  IconData iconeComputador = Icons.question_mark; 
  String resultado = "Escolha uma opção";
  int pontosJogador = 0;
  int pontosComputador = 0;
  List<String> opcoes = ["pedra", "papel", "tesoura"];

  // PASSO 9: Função para resetar o placar
  void resetarPlacar() {
    setState(() {
      pontosJogador = 0;
      pontosComputador = 0;
      resultado = "Placar zerado!";
      iconeComputador = Icons.question_mark;
    });
  }

  // PASSO 4, 5, 6 e 7: Lógica principal do jogo
  void jogar(String escolhaUsuario) {
    // PASSO 4: Gerar escolha aleatória do PC
    int numero = Random().nextInt(3); 
    String escolhaComputador = opcoes[numero];

    setState(() {
      // PASSO 5: Atualizar ícone do computador
      if (escolhaComputador == "pedra") {
        iconeComputador = Icons.landscape; // Representa a pedra
      } else if (escolhaComputador == "papel") {
        iconeComputador = Icons.pan_tool;
      } else if (escolhaComputador == "tesoura") {
        iconeComputador = Icons.content_cut;
      }

      // PASSO 6: Lógica de verificação de vencedor
      if (escolhaUsuario == escolhaComputador) {
        resultado = "Empate!";
      } else if (
        (escolhaUsuario == "pedra" && escolhaComputador == "tesoura") ||
        (escolhaUsuario == "papel" && escolhaComputador == "pedra") ||
        (escolhaUsuario == "tesoura" && escolhaComputador == "papel")
      ) {
        pontosJogador++;
        resultado = "Você venceu!";
      } else {
        pontosComputador++;
        resultado = "Computador venceu!";
      }

      // PASSO 7: Regra do campeonato (reset automático ao chegar em 5)
      if (pontosJogador == 5) {
        resultado = "🏆 Você ganhou o campeonato!";
        pontosJogador = 0;
        pontosComputador = 0;
      } else if (pontosComputador == 5) {
        resultado = "💻 PC ganhou o campeonato!";
        pontosJogador = 0;
        pontosComputador = 0;
      }
    });
  }

  // PASSO 8: Interface do App
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedra Papel Tesoura"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Escolha do Computador:", style: TextStyle(fontSize: 18)),
            Icon(
              iconeComputador,
              size: 100,
              color: Colors.blueGrey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                resultado,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "Você: $pontosJogador  |  PC: $pontosComputador",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.landscape, size: 40),
                  onPressed: () => jogar("pedra"),
                  tooltip: "Pedra",
                ),
                IconButton(
                  icon: Icon(Icons.pan_tool, size: 40),
                  onPressed: () => jogar("papel"),
                  tooltip: "Papel",
                ),
                IconButton(
                  icon: Icon(Icons.content_cut, size: 40),
                  onPressed: () => jogar("tesoura"),
                  tooltip: "Tesoura",
                ),
              ],
            ),
            SizedBox(height: 50),
            // PASSO 9: Botão de Reset manual
            ElevatedButton.icon(
              onPressed: resetarPlacar,
              icon: Icon(Icons.refresh),
              label: Text("Resetar Placar"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}