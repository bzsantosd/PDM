import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
    home: AppCadastroInteligente(),
  ));
}

class AppCadastroInteligente extends StatefulWidget {
  @override
  _AppCadastroInteligenteState createState() => _AppCadastroInteligenteState();
}

class _AppCadastroInteligenteState extends State<AppCadastroInteligente> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  List<Map<String, dynamic>> _itens = [];

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  Future<Database> _recuperarBanco() async {
    final caminho = await getDatabasesPath();
    final local = join(caminho, "banco_prova_v3.db");

    return await openDatabase(
      local,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dados(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descricao TEXT, data TEXT)"
        );
      },
    );
  }

 
  Future<void> _atualizarLista() async {
    final db = await _recuperarBanco();
    final List<Map<String, dynamic>> lista = await db.query("dados", orderBy: "titulo ASC");
    setState(() {
      _itens = lista;
    });
  }


  Future<void> _salvar(int? id) async {
    if (_tituloController.text.isEmpty) return;

    final db = await _recuperarBanco();
    String dataFormatada = DateTime.now().toString().substring(0, 16);

    Map<String, dynamic> dados = {
      "titulo": _tituloController.text,
      "descricao": _descricaoController.text,
      "data": dataFormatada,
    };

    if (id == null) {
      await db.insert("dados", dados);
    } else {
      await db.update("dados", dados, where: "id = ?", whereArgs: [id]);
    }

    _tituloController.clear();
    _descricaoController.clear();
    _atualizarLista();
  }

 
  Future<void> _deletar(int id) async {
    final db = await _recuperarBanco();
    await db.delete("dados", where: "id = ?", whereArgs: [id]);
    _atualizarLista();
  }

 
  void _exibirModal(BuildContext context, {int? id, String? titulo, String? descricao}) {
    if (id != null) {
      _tituloController.text = titulo!;
      _descricaoController.text = descricao!;
    } else {
      _tituloController.clear();
      _descricaoController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          top: 20, left: 20, right: 20
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(id == null ? "Novo Item" : "Editar Item 📝", 
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _tituloController, decoration: InputDecoration(labelText: "Título")),
            TextField(controller: _descricaoController, decoration: InputDecoration(labelText: "Descrição")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _salvar(id);
                Navigator.pop(ctx);
              },
              child: Text("Salvar"),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 45)),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro Inteligente"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _itens.isEmpty 
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
                  Text("Nenhum item cadastrado", style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ))
          : ListView.builder(
              itemCount: _itens.length,
              itemBuilder: (context, index) {
                final item = _itens[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    title: Text(item["titulo"], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${item["descricao"]}\n ${item["data"]}"),
                    isThreeLine: true,
                    onTap: () => _exibirModal(context, id: item["id"], titulo: item["titulo"], descricao: item["descricao"]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => _deletar(item["id"]),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _exibirModal(context),
        label: Text("Adicionar"),
        icon: Icon(Icons.add),
      ),
    );
  }
}