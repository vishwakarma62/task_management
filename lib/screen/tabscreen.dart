
import 'package:flutter/material.dart';
import 'package:task_management/screen/completetask.dart';
import 'package:task_management/screen/favouritetask.dart';
import 'package:task_management/screen/pendingtaskscreen.dart';
import 'package:task_management/screen/taskscreentwo.dart';

import 'drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  static const id = "tab_screen";

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, dynamic>> _Pagedetails = [
    {'pageName': const PendingTaskScreen(), 'title': 'pending task'},
    {'pageName': const CompleteTaskScreen(), 'title': 'complete task'},
    {'pageName': const FavoriteTaskScreen(), 'title': 'favorite task'},
  ];
  var _selectedpageindex = 0;
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_Pagedetails[_selectedpageindex]['title']),
        actions: [
          IconButton(
              onPressed: () {
                _addtask(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: DrawerPage(),
      body: _Pagedetails[_selectedpageindex]['pageName'],
      floatingActionButton: _selectedpageindex == 0
          ? FloatingActionButton(
              onPressed: () {
                _addtask(context);
              },
              tooltip: "Add Item",
              backgroundColor: Colors.lightBlueAccent,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedpageindex,
        onTap: (value) {
          setState(() {
            _selectedpageindex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: "Pending task"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
            ),
            label: "Complete task",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: "favorite task"),
        ],
      ),
    );
  }
}
