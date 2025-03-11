import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:todoui/provider/taskProvider.dart';
import '../Model/TaskModel.dart';

Future<void> showMyDialog(BuildContext context) async {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _desc_controller = TextEditingController();
  DateTime? dateTime;

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
              ElevatedButton(
                onPressed: () async {
                  dateTime = await showOmniDateTimePicker( // Remove local variable declaration
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
                    lastDate: DateTime.now().add(const Duration(days: 3652)),
                    padding: EdgeInsets.symmetric(),
                    barrierColor: Colors.transparent,
                    title: Text("Pick Date & Time"),
                    is24HourMode: false,
                    isShowSeconds: false,
                    minutesInterval: 1,
                    secondsInterval: 1,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    constraints: const BoxConstraints(
                      maxWidth: 350,
                      maxHeight: 650,
                    ),
                    transitionBuilder: (context, anim1, anim2, child) {
                      return FadeTransition(
                        opacity: anim1.drive(Tween(begin: 0, end: 1)),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 200),
                    barrierDismissible: true,
                    selectableDayPredicate: (dateTime) {
                      if (dateTime == DateTime(2023, 2, 25)) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                  );
                  debugPrint('dateTime: $dateTime');
                },
                child: Row(
                  children: [
                    Icon(Icons.punch_clock),
                    SizedBox(width: 5),
                    const Text('Pick Date & Time'),
                  ],
                ),
              ),

            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_titlecontroller.text.isEmpty ||
                    _desc_controller.text.isEmpty || dateTime == null) {
                  return;
                }
                context.read<TaskProvider>().addTask(
                  _titlecontroller.text,
                  _desc_controller.text,
                  dateTime!,
                );
                _titlecontroller.clear();
                _desc_controller.clear();
                dateTime = null;
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ),
        ],
      );
    },
  );
}
