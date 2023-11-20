// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final Task task;
  const AddTaskEvent({
    required this.task,
  });

 

   @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  const UpdateTaskEvent({
    required this.task,
  });



   @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;
  const DeleteTaskEvent({
    required this.task,
  });



   @override
  List<Object> get props => [task];
  
}

class RemoveTaskEvent extends TaskEvent {
  final Task task;
  const RemoveTaskEvent({
    required this.task,
  });



   @override
  List<Object> get props => [task];
}

class MarkFavouriteOrUnFavouriteTaskEvent extends TaskEvent{
  final Task task;

  MarkFavouriteOrUnFavouriteTaskEvent({required this.task});
    @override
  List<Object> get props => [task];
}

class EditTask extends TaskEvent{
  final Task oldtask;
  final Task newtask;

  EditTask({required this.oldtask, required this.newtask});
  List<Object> get props => [oldtask,newtask];
}