import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/tasks.dart';
import 'package:lista_de_tarefas/repositories/task_repository.dart';
import 'package:lista_de_tarefas/widgets/todo_list_item.dart';

class Todolistpage extends StatefulWidget {
  const Todolistpage({super.key});

  @override
  State<Todolistpage> createState() => _TodolistpageState();
}

class _TodolistpageState extends State<Todolistpage> {
  List<Tasks> tasks = [];
  String? errorText;
  int count = 0; // Variável para armazenar a contagem de tarefas

  final TextEditingController taskController = TextEditingController();
  final TaskRepository taskRepository = TaskRepository();

  @override
  void initState() {
    super.initState();
    taskRepository.getTaskList().then((value) {
      setState(() {
        tasks = value;
        count = tasks.length; // Atualiza a contagem de tarefas
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Ex: Estudar Flutter',
                          errorText: errorText,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String task = taskController.text;
                        if (task.isEmpty) {
                          setState(() {
                            errorText = 'Campo obrigatório';
                          });
                          return;
                        }
                        taskController.clear();
                        setState(
                          () {
                            Tasks newtask =
                                Tasks(title: task, date: DateTime.now());
                            tasks.add(newtask);
                            count =
                                tasks.length; // Atualiza a contagem de tarefas
                            errorText = null;
                          },
                        );
                        taskRepository.saveTaskList(tasks);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff00d7f3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(14),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Tasks task in tasks)
                        TodoListItem(
                          tasks: task,
                          deleteTask: deleteTask,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            'Você possui $count tarefas pendentes')), // Exibe a contagem de tarefas
                    ElevatedButton(
                      onPressed: showDeleteTasks,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff00d7f3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(14),
                      ),
                      child: Text(
                        'Limpar Tudo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask(Tasks task) {
    setState(() {
      tasks.remove(task);
      count = tasks.length; // Atualiza a contagem de tarefas
    });
    taskRepository.saveTaskList(tasks);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa removida com sucesso!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              tasks.add(task);
              count = tasks.length; // Atualiza a contagem de tarefas
            });
            taskRepository.saveTaskList(tasks);
          },
        ),
      ),
    );
  }

  void showDeleteTasks() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Limpar Tudo',
        ),
        content: Text('Você deseja realmente limpar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Text('Cancelar', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cleartasks();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Limpar Tudo', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  void cleartasks() {
    setState(() {
      tasks.clear();
      count = tasks.length; // Atualiza a contagem de tarefas
    });
    taskRepository.saveTaskList(tasks);
  }
}
