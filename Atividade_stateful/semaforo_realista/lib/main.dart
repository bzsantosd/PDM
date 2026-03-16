import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // PASSO 2: Chamando a classe principal
    home: SemaforoApp(), 
  ));
}

// PASSO 2: Definindo como StatefulWidget para permitir mudança de estado
class SemaforoApp extends StatefulWidget {
  @override
  _SemaforoAppState createState() => _SemaforoAppState();
}

class _SemaforoAppState extends State<SemaforoApp> {
  // O estado controla qual luz está acesa (0: Verde, 1: Amarelo, 2: Vermelho)
  int estado = 0;

  // PASSO 4: Função para alternar as cores
  void mudarSemaforo() {
    setState(() {
      estado++;
      if (estado > 2) {
        estado = 0; // Reinicia o ciclo
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Semáforo de Trânsito"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        // PASSO 7: Organizando o Layout Final
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // PASSO 3: Estrutura Visual do Semáforo (Carros)
            Container(
              width: 120,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // LUZ VERMELHA (Ativa quando estado é 2)
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: estado == 2 ? Colors.red : Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 10),
                  // LUZ AMARELA (Ativa quando estado é 1)
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: estado == 1 ? Colors.yellow : Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 10),
                  // LUZ VERDE (Ativa quando estado é 0)
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: estado == 0 ? Colors.green : Colors.grey[800],
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // PASSO 5: Semáforo de Pedestre
            Column(
              children: [
                Icon(
                  // Se o semáforo de carros está vermelho (2), pedestre pode andar
                  estado == 2 ? Icons.directions_walk : Icons.pan_tool,
                  size: 80,
                  color: estado == 2 ? Colors.green : Colors.red,
                ),
                Text(
                  estado == 2 ? "PEDESTRE: ATRAVESSE" : "PEDESTRE: AGUARDE",
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold,
                    color: estado == 2 ? Colors.green[700] : Colors.red[700],
                  ),
                )
              ],
            ),

            SizedBox(height: 40),

            // PASSO 6: Botão de Controle
            ElevatedButton(
              onPressed: mudarSemaforo,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Mudar Semáforo",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}