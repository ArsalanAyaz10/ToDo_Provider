import 'package:flutter/material.dart';
import 'TaskModel.dart';


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
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            "TODO with Provider",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
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

  final TextEditingController _taskController = TextEditingController();
  final List<Task> _taskList = [];

  void _addTask(String taskName) {
    setState(() {
      _taskList.add(Task(taskName: taskName));
    });
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _taskList[index].isDone = !(_taskList[index].isDone ?? false);
    });

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15,right: 10,left: 10,bottom: 5),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: "Task Name",
                ),
                controller: _taskController,
              ),
            ),
            ElevatedButton(
              onPressed: (){
                if(_taskController.text.isNotEmpty){
                  _addTask(_taskController.text);
                  _taskController.clear();
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.lightBlue),
              ),
              child: const Text("Submit",style: TextStyle(color: Colors.white),),
            ),

            Divider(color: Colors.white12,height: 5,),

            ListView.builder(
              shrinkWrap: true,
              itemCount: _taskList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final task = _taskList[index];
                return Card(
                  child: ListTile(
                    title: Text(task.taskName ?? "No Name"),
                    trailing: Checkbox(
                      value: task.isDone ?? false,
                      onChanged: (value){
                        _toggleTaskStatus(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
