import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoui/Model/TaskModel.dart';

class TaskProvider extends ChangeNotifier implements TaskModel {
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  @override
  late bool isCompleted;

  @override
  // TODO: implement dateTime
  DateTime get dateTime => throw UnimplementedError();

  @override
  // TODO: implement description
  String get description => throw UnimplementedError();

  @override
  // TODO: implement id
  int get id => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => throw UnimplementedError();

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
    notifyListeners();
    storeData();
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

  Future<void> storeData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('id', _tasks.length);
    await pref.setString('title', title);
    await pref.setString('description', description);
    await pref.setString('dateTime', dateTime.toIso8601String());
    await pref.setBool('isCompleted', isCompleted);
  }

  Future<void> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    int? userAge = prefs.getInt('user_age');
    bool? isLoggedIn = prefs.getBool('is_logged_in');

    print('Username: $username');
    print('Age: $userAge');
    print('Logged in: $isLoggedIn');
  }

  void clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
