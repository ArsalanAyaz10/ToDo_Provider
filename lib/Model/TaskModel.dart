import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskModel {
  final int id;
  final String title;
  final String description;
  bool isCompleted;
  final DateTime dateTime;

  TaskModel(
    this.id, {
    required this.title,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
  });


}
