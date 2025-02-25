import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: const Text(
            "TO DO LIST UI",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
        ),
        body: const BuildUI(),
      ),
    );
  }
}

class BuildUI extends StatefulWidget {
  const BuildUI({super.key});

  @override
  State<BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<BuildUI> {

  final List<String> tasks = ["Clean House", "Buy Groceries", "Make Dinner", "Wash Clothes"];

  List<bool> isDone = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: List.generate(tasks.length, (index) {
            return Column(
              children: [
                Card(
                  color: Colors.black12,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        isDone[index] = !isDone[index];
                      });
                    },
                    trailing: Icon(
                      isDone[index] ? Icons.cancel : Icons.check,
                      color: isDone[index] ? Colors.red : Colors.green,
                    ),
                    title: Text(
                      tasks[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            );
          }),
        ),
      ),
    );
  }
}
