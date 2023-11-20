

import 'package:flutter/material.dart';
import 'package:task_management/screen/taskscreentwo.dart';

import '../bloc/exportbloc.dart';
import '../model/task.dart';
import '../widget/tasklist.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  static const id = "task_screen";

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  void initState() {
    super.initState();
  }

  // String uuid = Uuid().v4();
  // void _generateNewUuid() {
  //   setState(() {
  //     uuid = Uuid().v4(); // Generate a new random UUID
  //   });
  // }

  void _addtask(BuildContext context) {
    showModalBottomSheet(
        context: (context),
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const AddTaskScreen(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasklist = state.completetask;
        return Scaffold(
          body: Column(
            children: [
              Center(
                  child:
                      Chip(label: Text("${state.completetask.length} Task"))),
              TaskList(tasklist: tasklist),
            ],
          ),
        );
      },
    );
  }
}
