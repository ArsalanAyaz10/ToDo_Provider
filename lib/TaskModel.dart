import 'package:flutter/cupertino.dart';

class Task {
  String? taskName;
  bool? isDone;
  DateTime? dueDate;
  String? priority;

  Task({this.taskName, this.isDone = false, this.dueDate, this.priority});
}

