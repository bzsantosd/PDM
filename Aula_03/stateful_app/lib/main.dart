import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: PaginaContador()));
}

class PaginaContador extends StatefulWidget {
  @override
  _PaginaContadorState createState() => _PaginaContadorState();
}

class _PaginaContadorState extends State<PaginaContador> {
int contador = 0;

  void main() {
    setState(() {
      int max = 1;
      int min = 10;

 int sorteado =Random().nextInt(max - min + 1 ) + min;
 contador = sorteado;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu App Interativo")),
      body: Center(
        child: Text("Numero soriado: $contador", style: TextStyle(fontSize: 30)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: main,
        child: Icon(Icons.add),
      ),
    );
  }
}