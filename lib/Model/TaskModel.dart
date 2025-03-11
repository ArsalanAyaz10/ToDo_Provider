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

    // Convert TaskModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  // Convert JSON to TaskModel
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      isCompleted: json['isCompleted'],
    );
  }
}
