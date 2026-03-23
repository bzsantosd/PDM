import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListaContatos(),
  ));
}

// Modelo de Dados para facilitar a organização
class Contato {
  final String nome;
  final String telefone;
  final IconData icone;
  final Color cor;

  Contato(this.nome, this.telefone, this.icone, this.cor);
}

//-------------- TELA 1 --------------

class ListaContatos extends StatelessWidget {
  // Lista fixa de contatos (Pelo menos 3)
  final List<Contato> contatos = [
    Contato("Beatriz", "(19) 99999-9999", Icons.favorite, Colors.purple), 
    Contato("Bruno", "(19) 98888-9898", Icons.work, Colors.orangeAccent),
    Contato("Victor", "(19) 98989-8888", Icons.person, Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Contatos 📋"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: contato.cor,
              child: Icon(contato.icone, color: Colors.white),
            ),
            title: Text(contato.nome),
            subtitle: Text(contato.telefone),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheContato(contato: contato),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//-------------- TELA 2 --------------

class DetalheContato extends StatelessWidget {
  final Contato contato;

  DetalheContato({required this.contato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes de ${contato.nome}"),
        backgroundColor: contato.cor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: contato.nome,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: contato.cor,
                  child: Icon(contato.icone, size: 50, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Text(contato.nome, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Text(contato.telefone, style: TextStyle(fontSize: 20, color: Colors.grey[600])),
              SizedBox(height: 30),
              
              // Desafio Extra
              ElevatedButton.icon(
                icon: Icon(Icons.phone),
                label: Text("Ligar para ${contato.nome}"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Ligando para ${contato.telefone}... ☎️")),
                  );
                },
              ),
              
              TextButton(
                child: Text("Voltar"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


