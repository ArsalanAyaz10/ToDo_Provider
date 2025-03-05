import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoui/taskCard.dart';
import 'TaskModel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TaskProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<TaskProvider>(
        builder: (context, value, child) {
          return Scaffold(
             floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await _showMyDialog(context);
                },
                shape: CircleBorder(),
                focusElevation: 2,
                splashColor: Colors.lightBlue,
                elevation: 2,
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                backgroundColor: Colors.blue,
                centerTitle: true,
                elevation: 2,
                title: const Text(
                  "To Do with Provider",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              body: const BuildUI(),
            );
        },
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

  @override
  Widget build(BuildContext context) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [

             Consumer<TaskProvider>(
        builder: (context, Task, child) {
          if(context.watch<TaskProvider>().tasks.isEmpty){
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text("No tasks added yet"),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.only(top: 20, bottom: 5,left: 5,right: 5),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: context
                .watch<TaskProvider>()
                .tasks
                .length,
            itemBuilder: (context, index) {
              final task = context
                  .watch<TaskProvider>()
                  .tasks[index];
              return taskCard(
                index: index,
                taskTitle: task.title,
                description: task.description,
                isCompleted: task.isCompleted,
              );
            },
          );
        },
             ),
              ]
            ),
          ),
        );
  }
}


//task dialog box

Future<void> _showMyDialog(BuildContext context) async {

  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _desc_controller = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: const Text('Add Task'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _titlecontroller,
                  decoration: InputDecoration(
                    labelText: "Task Title",
                    prefixIcon: const Icon(Icons.event_note_outlined),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 246, 246, 246),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter task title';
                    }
                    return null;
                  },
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _desc_controller,
                  decoration: InputDecoration(
                    labelText: "Task Description",
                    prefixIcon: const Icon(Icons.pending_actions),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 246, 246, 246),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter task Description';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: () {
            if(_titlecontroller.text.isEmpty || _desc_controller.text.isEmpty){
              return;
            }
            context.read<TaskProvider>().addTask(_titlecontroller.text, _desc_controller.text);
            _titlecontroller.clear();
            _desc_controller.clear();
            Navigator.of(context).pop();
          },
            child: Text("Add"),
          ),
        ],
      );
    },
  );
}
