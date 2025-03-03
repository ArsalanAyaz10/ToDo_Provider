import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TaskModel.dart';

class taskCard extends StatefulWidget {
  final int index;
  final String taskTitle;
  final String description;
   final bool isCompleted;

  const taskCard({super.key, required this.taskTitle,required this.description,required this.isCompleted, required this.index});

  @override
  State<taskCard> createState() => _taskCardState();
}

class _taskCardState extends State<taskCard> {
  @override
  Widget build(BuildContext context) {
  return Dismissible(
    onDismissed: (direction) {
      setState(() {
         Provider.of<TaskProvider>(context, listen: false).removeTask(widget.index);
      });
    },
    behavior: HitTestBehavior.opaque,
    key: UniqueKey(),
    child: Card(
      shadowColor: Colors.black,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            autofocus: true,
            title: Text(widget.taskTitle),
            subtitle: Text(widget.description),
            focusColor: Colors.white60,
            trailing: Checkbox(
        value: widget.isCompleted,
        onChanged: (value) {
          Provider.of<TaskProvider>(context, listen: false).toggleTask(widget.index);
        },
      ),

      dense: true,
            hoverColor: Colors.white12,
            mouseCursor: WidgetStateMouseCursor.clickable,
            contentPadding: const EdgeInsets.all(10),
          ),
        ],
      ),
    ),
  );
  }
}
