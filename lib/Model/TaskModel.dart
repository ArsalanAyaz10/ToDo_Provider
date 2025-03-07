import 'package:flutter/material.dart';

class TaskModel {
  final int id;
  final String title;
  final String description;
  bool isCompleted;

  TaskModel(
    this.id, {
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void addTask(String title, String description) {
    _tasks.add(
      TaskModel(
        _tasks.length,
        title: title,
        description: description,
        isCompleted: false,
      ),
    );
    notifyListeners();
  }

  void removeTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void toggleTask(int id) {
    int index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }
}
