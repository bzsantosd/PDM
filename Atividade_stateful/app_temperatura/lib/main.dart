import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // PASSO 2: Chamando o widget principal
    home: TemperaturaApp(),
  ));
}

// PASSO 2: Definindo como StatefulWidget para permitir mudanças de estado
class TemperaturaApp extends StatefulWidget {
  @override
  _TemperaturaAppState createState() => _TemperaturaAppState();
}

class _TemperaturaAppState extends State<TemperaturaApp> {
  // Estado inicial
  int temperatura = 20;

  // PASSO 3: Função para aumentar a temperatura
  void aumentar() {
    setState(() {
      temperatura++;
    });
  }

  // PASSO 4: Função para diminuir a temperatura
  void diminuir() {
    setState(() {
      temperatura--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // PASSO 6: Lógica de Temperatura (Definição de variáveis)
    Color corFundo;
    IconData icone;
    String status;

    if (temperatura < 15) {
      corFundo = Colors.blue;
      icone = Icons.ac_unit;
      status = "Frio";
    } else if (temperatura < 30) {
      corFundo = Colors.green;
      icone = Icons.wb_sunny;
      status = "Agradável";
    } else {
      corFundo = Colors.red;
      icone = Icons.local_fire_department;
      status = "Quente";
    }

    return Scaffold(
      // PASSO 7: Aplicando a cor de fundo dinâmica
      backgroundColor: corFundo,
      appBar: AppBar(
        title: Text("Controle de Temperatura"),
        backgroundColor: Colors.white.withOpacity(0.3),
        elevation: 0,
      ),
      body: Center(
        // PASSO 5: Interface com Column e Row
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // PASSO 7: Exibindo o Ícone dinâmico
            Icon(
              icone,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "$temperatura °C",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            // PASSO 7: Exibindo o Status dinâmico
            Text(
              status,
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botão Diminuir
                ElevatedButton(
                  onPressed: diminuir,
                  child: Text("-", style: TextStyle(fontSize: 30)),
                  style: ElevatedButton.styleFrom(shape: CircleBorder(), padding: EdgeInsets.all(20)),
                ),
                SizedBox(width: 40),
                // Botão Aumentar
                ElevatedButton(
                  onPressed: aumentar,
                  child: Text("+", style: TextStyle(fontSize: 30)),
                  style: ElevatedButton.styleFrom(shape: CircleBorder(), padding: EdgeInsets.all(20)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}