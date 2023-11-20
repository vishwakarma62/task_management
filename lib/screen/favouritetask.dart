

import 'package:flutter/material.dart';
import 'package:task_management/screen/taskscreentwo.dart';

import '../bloc/exportbloc.dart';
import '../model/task.dart';
import '../widget/tasklist.dart';

class FavoriteTaskScreen extends StatefulWidget {
  const FavoriteTaskScreen({super.key});

  static const id = "task_screen";

  @override
  State<FavoriteTaskScreen> createState() => _FavoriteTaskScreenState();
}

class _FavoriteTaskScreenState extends State<FavoriteTaskScreen> {
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
        List<Task> tasklist = state.favoritetask;
        return Scaffold(
          
          body: Column(
            children: [
              Center(
                  child:
                      Chip(label: Text("${state.favoritetask.length} Task"))),
              TaskList(tasklist: tasklist),
            ],
          ),
        );
      },
    );
  }
}
