import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: PaginaPrincipal(),
  ));
}

class PaginaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meu App de Organização"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.note), text: "Notas"),
              Tab(icon: Icon(Icons.shopping_cart), text: "Compras"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AppNotas(),        // Atividade 1
            ListaCompras(),    // Atividade 2
          ],
        ),
      ),
    );
  }
}

// ---  ATIVIDADE 1 ---
class AppNotas extends StatefulWidget {
  @override
  _AppNotasState createState() => _AppNotasState();
}

class _AppNotasState extends State<AppNotas> {
  List<String> notas = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarNotas();
  }

  void adicionarNota() {
    if (controller.text.isNotEmpty) {
      setState(() {
        notas.add(controller.text);
        controller.clear();
      });
      salvarNotas();
    }
  }

  void removerNota(int index) {
    setState(() {
      notas.removeAt(index);
    });
    salvarNotas();
  }

  void salvarNotas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("notas", notas);
  }

  void carregarNotas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notas = prefs.getStringList("notas") ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: "Digite uma nota",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(icon: Icon(Icons.add), onPressed: adicionarNota),
            ),
          ),
        ),
        Expanded(
          child: notas.isEmpty
              ? Center(child: Text("Nenhuma nota ainda"))
              : ListView.builder(
                  itemCount: notas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(notas[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => removerNota(index),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// --- ATIVIDADE 2---
class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  List<String> itens = [];
  List<bool> comprado = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void adicionarItem() {
    if (controller.text.isNotEmpty) {
      setState(() {
        itens.add(controller.text);
        comprado.add(false);
        controller.clear();
      });
      salvarDados();
    }
  }

  void alternarComprado(int index) {
    setState(() {
      comprado[index] = !comprado[index];
    });
    salvarDados();
  }

  void removerItem(int index) {
    setState(() {
      itens.removeAt(index);
      comprado.removeAt(index);
    });
    salvarDados();
  }

  void salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("itens_compras", itens);
    await prefs.setStringList("comprado_status", comprado.map((e) => e.toString()).toList());
  }

  void carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      itens = prefs.getStringList("itens_compras") ?? [];
      List<String> listaBool = prefs.getStringList("comprado_status") ?? [];
      comprado = listaBool.map((e) => e == "true").toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: "O que precisa comprar?"),
                ),
              ),
              ElevatedButton(onPressed: adicionarItem, child: Text("Add")),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total de itens: ${itens.length}", style: TextStyle(fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  setState(() { itens.clear(); comprado.clear(); });
                  salvarDados();
                },
                child: Text("Limpar Tudo", style: TextStyle(color: Colors.red)),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: itens.length,
            itemBuilder: (context, index) {
              return Card(
                color: comprado[index] ? Colors.green[50] : Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: Checkbox(
                    value: comprado[index],
                    onChanged: (value) => alternarComprado(index),
                  ),
                  title: Text(
                    itens[index],
                    style: TextStyle(
                      decoration: comprado[index] ? TextDecoration.lineThrough : TextDecoration.none,
                      color: comprado[index] ? Colors.grey : Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () => removerItem(index),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}