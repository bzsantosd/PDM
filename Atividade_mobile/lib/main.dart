import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<String> tarefas = [];
  final TextEditingController controller = TextEditingController();

  void adicionarTarefa() {
    // DESAFIO 1: Impedir adicionar tarefa vazia (usando trim para ignorar espaços)
    if (controller.text.trim().isNotEmpty) {
      setState(() {
        tarefas.add(controller.text);
      });
      controller.clear();
    }
  }

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // DESAFIO 2: Mostrar quantidade de tarefas no AppBar
        title: Text("Lista de Tarefas (${tarefas.length})"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              // DESAFIO 3: Permitir adicionar pressionando Enter
              onSubmitted: (_) => adicionarTarefa(),
              decoration: const InputDecoration(
                labelText: "Digite uma nova tarefa",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: adicionarTarefa,
              child: const Text("Adicionar"),
            ),
            const Divider(height: 30),
            
            // DESAFIO 4: Mostrar mensagem se a lista estiver vazia
            Expanded(
              child: tarefas.isEmpty
                  ? const Center(
                      child: Text(
                        "Nenhuma tarefa cadastrada!",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(tarefas[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),
                            onPressed: () => removerTarefa(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}