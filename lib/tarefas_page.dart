import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late SharedPreferences prefs;

  List<String> tarefas = ["Pagar contas", "Compras supermercado"];
  String novaTarefa = "";

  void addTarefa() {
    if (novaTarefa != "") {
      setState(() {
        tarefas.add(novaTarefa);
      });
      prefs.setStringList("tarefas", tarefas);
    }
  }

  void removeTarefa(String tarefa) {
    setState(() {
      tarefas.remove(tarefa);
    });
    prefs.setStringList("tarefas", tarefas);
  }

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      tarefas = prefs.getStringList("tarefas") ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Tarefas"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            ...tarefas.map((tarefa) => GestureDetector(
                onTap: () {
                  removeTarefa(tarefa);
                },
                child: Card(
                    child: Container(
                        padding: EdgeInsets.all(20), child: Text(tarefa)))))
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 60,
          color: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 950,
                      child: TextFormField(
                        onChanged: (valor) {
                          novaTarefa = valor;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      addTarefa();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.orange,
                      child: Icon(Icons.add),
                    ),
                  )
                ]),
          )),
    );
  }
}
