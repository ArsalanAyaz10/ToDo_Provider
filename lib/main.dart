import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoui/Screens/HomeScreen.dart';
import 'package:todoui/Screens/getStarted.dart';
import 'package:todoui/provider/taskProvider.dart';
import 'Model/TaskModel.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TaskProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: getStartedPage(),
    );
  }
}

