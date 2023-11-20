
import 'package:flutter/material.dart';
import 'package:task_management/bloc/exportbloc.dart';
import 'package:task_management/bloc/taskbloc/task_bloc.dart';
import 'package:task_management/screen/recycle_bin.dart';
import 'package:task_management/screen/tabscreen.dart';


class DrawerPage extends StatefulWidget {
  const DrawerPage({
    super.key,
  });

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

bool isSwitched = false;

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
              child: Container(
                color: Colors.green,
                child: Text(
                  "Task Drawer",
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(TabScreen.id);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text("My Tasks"),
                    trailing: Text("${state.pendingtask.length} | ${state.completetask.length}"),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(RecycleBin.id);
                },
                child: ListTile(
                  leading: const Icon(Icons.folder_special),
                  title: const Text("Bin"),
                  trailing: Text("${state.removetask.length}"),
                ),
              );
            }),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Column(
                  children: [
                   
                    Switch(
                        value: state.switchvalue,
                        onChanged: (newvalue) {
                          newvalue
                              ? context.read<SwitchBloc>().add(SwitchOffEvent())
                              : context.read<SwitchBloc>().add(SwitchOnEvent());
                              
                        }),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
