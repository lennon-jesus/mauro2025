import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'task.dart';

void main() => runApp(MaterialApp(home: TaskHome()));

class TaskHome extends StatefulWidget {
  @override
  _TaskHomeState createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  DBHelper db = DBHelper.instance;
  List<Task> tasks = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  loadTasks() async {
    tasks = await db.getAllTasks();
    setState(() {});
  }

  createTask() async {
    await db.insertTask(Task(
      title: titleController.text,
      date: dateController.text,
    ));
    titleController.clear();
    dateController.clear();
    loadTasks();
  }

  editTask(Task t) async {
    titleController.text = t.title;
    dateController.text = t.date;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Alterar tarefa"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Título")),
            TextField(controller: dateController, decoration: InputDecoration(labelText: "Data")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              t.title = titleController.text;
              t.date = dateController.text;
              await db.updateTask(t);
              Navigator.pop(context);
              loadTasks();
            },
            child: Text("Salvar"),
          ),
        ],
      ),
    );
  }

  viewByDate() async {
    await showDialog(
      context: context,
      builder: (_) {
        TextEditingController filter = TextEditingController();
        return AlertDialog(
          title: Text("Filtrar por data"),
          content: TextField(
            controller: filter,
            decoration: InputDecoration(labelText: "Data (AAAA-MM-DD)"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                tasks = await db.getTasksByDate(filter.text);
                Navigator.pop(context);
                setState(() {});
              },
              child: Text("Filtrar"),
            )
          ],
        );
      },
    );
  }

  resetList() async {
    tasks = await db.getAllTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas (SQLite)"),
        actions: [
          IconButton(icon: Icon(Icons.filter_alt), onPressed: viewByDate),
          IconButton(icon: Icon(Icons.refresh), onPressed: resetList),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, i) {
          var t = tasks[i];
          return Card(
            child: ListTile(
              title: Text(
                t.title,
                style: TextStyle(
                  decoration: t.done == 1 ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text("Data: ${t.date}"),
              leading: IconButton(
                icon: Icon(
                  t.done == 1 ? Icons.check_box : Icons.check_box_outline_blank,
                ),
                onPressed: () async {
                  await db.markDone(t.id!, t.done == 1 ? 0 : 1);
                  loadTasks();
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => editTask(t),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Nova tarefa"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: titleController, decoration: InputDecoration(labelText: "Título")),
                  TextField(controller: dateController, decoration: InputDecoration(labelText: "Data (AAAA-MM-DD)")),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    createTask();
                    Navigator.pop(context);
                  },
                  child: Text("Criar"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
