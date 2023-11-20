
import 'package:flutter/material.dart';
import 'package:task_management/bloc/exportbloc.dart';
import 'package:task_management/bloc/taskbloc/task_bloc.dart';
import 'package:task_management/service/guid_gen.dart';

import '../model/task.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({
    required this.oldtask,
    super.key,
  });
  Task oldtask;
  @override
  State<EditTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<EditTaskScreen> {
  TextEditingController? titleCtr;
  TextEditingController? descriptionCtr;
  @override
  void initState() {
    titleCtr = TextEditingController(text: widget.oldtask.title);
    descriptionCtr = TextEditingController(text: widget.oldtask.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              TextField(
                autofocus: true,
                controller: titleCtr,
                decoration: const InputDecoration(
                  label: Text("title"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                autofocus: true,
                controller: descriptionCtr,
                decoration: const InputDecoration(
                  label: Text("description"),
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                children: [
                  TextButton(onPressed: () {}, child: const Text("cancel")),
                  TextButton(
                      onPressed: () {
                        var newtask = Task(
                            date: '',
                            title: titleCtr!.text,
                            id: GUIDGen.generate(),
                            isfavourited: widget.oldtask.isfavourited,
                            isdone: false,
                            description: descriptionCtr!.text);
                        context
                            .read<TaskBloc>()
                            .add(EditTask(oldtask: widget.oldtask,newtask: newtask));

                        Navigator.pop(context);
                      },
                      child: const Text("Add")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
