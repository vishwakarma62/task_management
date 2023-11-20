

import 'package:flutter/material.dart';
import 'package:task_management/screen/taskscreentwo.dart';

import '../bloc/exportbloc.dart';
import '../model/task.dart';
import '../widget/tasklist.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({super.key});

  static const id = "task_screen";

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
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
  bool iswitched = false;
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
        List<Task> tasklist = state.pendingtask;
        return Scaffold(
        
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Chip(
                        label: Text(
                            "${tasklist.length} Pending | ${state.completetask.length} Completed"))),
                TaskList(tasklist: tasklist),
              ],
            ),
          ),
        );
      },
    );
  }
}
