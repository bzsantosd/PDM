import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: PaginaContador()));
}

class PaginaContador extends StatefulWidget{
  @override
  PaginaContadorState createState() => PaginaContadorState
}

class PaginaContadorState extends State<PaginaContador> {
  int contador = 0;

  void increment() {
    setState(() {
      contador++;
    });
  }

  @override
   widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu App Interativo")),
      body: Center (child: Text("Cliques: $contador",),)
      style: TextStyle(fontSize: 30),
      ),
      ),
    )
  }
}