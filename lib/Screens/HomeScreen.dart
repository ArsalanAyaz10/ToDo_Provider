import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/TaskModel.dart';
import '../Widgets/dialogBox.dart';
import '../Widgets/taskCard.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(52, 78, 163,1),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showMyDialog(context);
            },
            shape: CircleBorder(),
            focusElevation: 2,
            splashColor: Colors.lightBlue,
            elevation: 2,
            backgroundColor: Colors.purpleAccent,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Icon(Icons.search, color: Colors.white),
              const SizedBox(width: 30),
              Icon(Icons.notifications_none, color: Colors.white),
              SizedBox(width: 10,),
            ],
            iconTheme: IconThemeData(color: Colors.white),
          ),
          drawer: Drawer(
            shape:RoundedRectangleBorder(),
            backgroundColor: Color.fromRGBO(27, 71, 170, 1.0),
            width: 270,
            shadowColor: Colors.white,
            elevation: 2,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children: [
                const SizedBox(height: 30),
                ListTile(
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text(
                    "Dashboard",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  leading: const Icon(
                    Icons.dashboard,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text(
                    "Profile",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  leading: const Icon(
                    Icons.portrait,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text(
                    "Settings",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),

          ),
          body: BuildUI(userName: widget.userName,),
        );
      },
    );
  }
}


class BuildUI extends StatefulWidget {
  final String userName;
  const BuildUI({super.key, required this.userName});

  @override
  State<BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<BuildUI> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Hello ${widget.userName}! ",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("TODAY'S TASKS",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${context.watch<TaskProvider>().tasks.length} tasks",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                ),
              ],),
              Consumer<TaskProvider>(
                builder: (context, Task, child) {
                  if(context.watch<TaskProvider>().tasks.isEmpty){
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text("No tasks added yet",style:
                          TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                          ),),
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

