import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:todoui/Model/TaskModel.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  TaskProvider() {
    fetchData(); // Load saved tasks when the provider is created
  }

  void addTask(String title, String description, DateTime dateTime) {
    _tasks.add(
      TaskModel(
        _tasks.length,
        title: title,
        description: description,
        dateTime: dateTime,
        isCompleted: false,
      ),
    );
    storeData(); // Save tasks to SharedPreferences
    notifyListeners();
  }

  void removeTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    storeData(); // Save updated list
    notifyListeners();
  }

  void toggleTask(int id) {
    int index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      storeData(); // Save updated task state
      notifyListeners();
    }
  }

  // ✅ Store all tasks as JSON
  Future<void> storeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskList =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList('tasks', taskList);
  }

  // ✅ Fetch tasks from SharedPreferences
  Future<void> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('tasks');

    if (taskList != null) {
      _tasks = taskList.map((task) => TaskModel.fromJson(jsonDecode(task))).toList();
      notifyListeners();
    }
  }

  void clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _tasks.clear();
    notifyListeners();
  }
}
