import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_tarefas/models/tasks.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem(
      {super.key, required this.tasks, required this.deleteTask});

  final Tasks tasks;
  final Function(Tasks) deleteTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                deleteTask(tasks);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Excluir',
              autoClose: true,
              spacing: 4,
              padding: EdgeInsets.symmetric(horizontal: 4),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(tasks.date),
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                tasks.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
