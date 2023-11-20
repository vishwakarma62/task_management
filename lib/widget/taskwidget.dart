
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_management/bloc/taskbloc/task_bloc.dart';
import 'package:task_management/screen/edittaskscreen.dart';

import '../model/task.dart';

// ignore: must_be_immutable
class TaskWidgetPage extends StatefulWidget {
  TaskWidgetPage({super.key, required this.taskitem});
  Task taskitem;

  @override
  State<TaskWidgetPage> createState() => _TaskWidgetPageState();
}

void _removeOrdeletetask(BuildContext ctx, Task task) {
  task.isdeleted!
      ? ctx.read<TaskBloc>().add(DeleteTaskEvent(task: task))
      : ctx.read<TaskBloc>().add(RemoveTaskEvent(task: task));
}

class _TaskWidgetPageState extends State<TaskWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                widget.taskitem.isfavourited == false
                    ? Icon(Icons.star_outline)
                    : Icon(Icons.star),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${widget.taskitem.title}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: widget.taskitem.isdone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(
                        DateFormat().add_yMMMd().add_Hms().format(
                              DateTime.now(),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
              value: widget.taskitem.isdone,
              onChanged: widget.taskitem.isdeleted == false
                  ? (value) {
                      context
                          .read<TaskBloc>()
                          .add(UpdateTaskEvent(task: widget.taskitem));
                    }
                  : null),
          PopupMenuButton(
            itemBuilder: widget.taskitem.isdeleted == false
                ? (context) => [
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.edit),
                            label: Text('Edit')),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return EditTaskScreen(oldtask: widget.taskitem);
                            },
                          ));
                        },
                      ),
                      PopupMenuItem(
                        child: TextButton.icon(
                          onPressed: null,
                          icon: widget.taskitem.isfavourited == false
                              ? Icon(Icons.bookmark)
                              : Icon(Icons.bookmark_remove),
                          label: widget.taskitem.isfavourited == false
                              ? Text('Add to Bookmark')
                              : Text('Remove from bookmark'),
                        ),
                        onTap: () {
                          context.read<TaskBloc>()
                            ..add(
                              MarkFavouriteOrUnFavouriteTaskEvent(
                                  task: widget.taskitem),
                            );
                        },
                      ),
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.delete),
                            label: Text('Delete')),
                        onTap: () =>
                            _removeOrdeletetask(context, widget.taskitem),
                      ),
                    ]
                : (context) => [
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.restore_from_trash),
                            label: Text('Restore')),
                      ),
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.delete_forever),
                            label: Text('Delete Forever')),
                        onTap: () {
                          _removeOrdeletetask(context, widget.taskitem);
                        },
                      ),
                    ],
          )
        ],
      ),
    );
  }
}
    // return ListTile(
    //   onTap: () {},
    //   leading: Text(
    //     widget.taskitem.title,
    //     overflow: TextOverflow.ellipsis,
    //     style: TextStyle(
    //         decoration: widget.taskitem.isdeleted == false
    //             ? null
    //             : TextDecoration.lineThrough),
    //   ),
    //   onLongPress: () {
    //     _removeOrdeletetask(context, widget.taskitem);
    //   },
    //   trailing: Checkbox(
    //       value: widget.taskitem.isdone,
    //       onChanged: widget.taskitem.isdeleted == false
    //           ? (value) {
    //               context
    //                   .read<TaskBloc>()
    //                   .add(UpdateTaskEvent(task: widget.taskitem));
    //             }
    //           : null),
    // );
//   }
// }
