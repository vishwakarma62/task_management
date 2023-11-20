import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../model/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTaskEvent>(addTaskEvent);
    on<UpdateTaskEvent>(updateTaskEvent);
    on<DeleteTaskEvent>(deleteTaskEvent);
    on<RemoveTaskEvent>(removeTaskEvent);
    on<MarkFavouriteOrUnFavouriteTaskEvent>(
        markFavouriteOrUnFavouriteTaskEvent);
    on<EditTask>(editTask);
  }

  FutureOr<void> addTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(
        pendingtask: List.from(state.pendingtask)..add(event.task),
        removetask: state.removetask,
        completetask: state.completetask,
        favoritetask: state.favoritetask));
  }

  FutureOr<void> updateTaskEvent(
      UpdateTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    //var task = event.task;

    List<Task> pendingtask = state.pendingtask;
    List<Task> completetask = state.completetask;

    event.task.isdone == false
        ? {
            pendingtask = List.from(pendingtask)..remove(event.task),
            completetask = List.from(completetask)
              ..insert(0, event.task.copyWith(isdone: true)),
          }
        : {
            completetask = List.from(completetask)..remove(event.task),
            pendingtask = List.from(pendingtask)
              ..insert(0, event.task.copyWith(isdone: false)),
          };

    emit(TaskState(
        pendingtask: pendingtask,
        completetask: completetask,
        removetask: state.removetask,
        favoritetask: state.favoritetask));
  }

  FutureOr<void> deleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      pendingtask: state.pendingtask,
      completetask: state.completetask,
      favoritetask: state.favoritetask,
      removetask: List.from(state.removetask)..remove(event.task),
    ));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }

  FutureOr<void> removeTaskEvent(
      RemoveTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        pendingtask: List.from(state.pendingtask)..remove(event.task),
        completetask: List.from(state.completetask)..remove(event.task),
        favoritetask: List.from(state.favoritetask)..remove(event.task),
        removetask: List.from(state.removetask)
          ..add(event.task.copyWith(isdeleted: true))));
  }

  FutureOr<void> markFavouriteOrUnFavouriteTaskEvent(
      MarkFavouriteOrUnFavouriteTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> pendingtask = List.from(state.pendingtask);
    List<Task> completetask = List.from(state.completetask);
    List<Task> favoritetask = List.from(state.favoritetask);
    if (event.task.isdone == false) {
      if (event.task.isfavourited == false) {
        var taskIndex = pendingtask.indexOf(event.task);
        pendingtask = List.from(pendingtask)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isfavourited: true),
          );
        favoritetask.insert(
          0,
          event.task.copyWith(isfavourited: true),
        );
      } else {
        var taskIndex = pendingtask.indexOf(event.task);
        pendingtask = List.from(pendingtask)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isfavourited: false),
          );
        favoritetask.remove(event.task);
      }
    } else {
      if (event.task.isfavourited == false) {
        var taskIndex = completetask.indexOf(event.task);
        completetask = List.from(completetask)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isfavourited: true),
          );
        favoritetask.insert(
          0,
          event.task.copyWith(isfavourited: true),
        );
      } else {
        var taskIndex = completetask.indexOf(event.task);
        completetask = List.from(completetask)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isfavourited: false),
          );
        favoritetask.remove(event.task);
      }
    }
    print('favourite');
    emit(
      TaskState(
          pendingtask: pendingtask,
          completetask: completetask,
          favoritetask: favoritetask,
          removetask: state.removetask),
    );
  }

  FutureOr<void> editTask(EditTask event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> favoritetask = List.from(state.favoritetask);
    if (event.oldtask.isfavourited == true) {
      favoritetask
        ..remove(event.oldtask)
        ..insert(0, event.newtask);
    }
    emit(
      TaskState(
        pendingtask: List.from(state.pendingtask)
          ..remove(event.oldtask)
          ..insert(0, event.newtask),
        completetask: state.completetask..remove(event.oldtask),
        favoritetask: favoritetask,
        removetask: state.removetask,
      ),
    );
  }
}
