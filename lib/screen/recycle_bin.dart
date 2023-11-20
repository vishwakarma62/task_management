import 'package:flutter/material.dart';

import '../bloc/exportbloc.dart';
import '../widget/tasklist.dart';
import 'drawer.dart';

class RecycleBin extends StatefulWidget {
  const RecycleBin({super.key});

    static const id="Recycle_bin";

  @override
  State<RecycleBin> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc,TaskState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.teal,
            actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
            title: Text(
              "Recycle Bin",
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
            ),
          ),
           drawer: DrawerPage(),
          body: Column(
            children: [
              Center(child: Chip(label: Text("${state.removetask.length} Task"))),
              TaskList(tasklist: state.removetask),
            ],
          ),
        );
      }
    );
  }
}
