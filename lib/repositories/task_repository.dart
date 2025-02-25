import 'package:lista_de_tarefas/models/tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskRepository {
  TaskRepository() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  late SharedPreferences sharedPreferences;

  Future<List<Tasks>> getTaskList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString('tasks') ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Tasks.fromJson(e)).toList();
  }

  void saveTaskList(List<Tasks> tasks) {
    final jsonString = json.encode(tasks);
    sharedPreferences.setString('tasks', jsonString);
  }
}
