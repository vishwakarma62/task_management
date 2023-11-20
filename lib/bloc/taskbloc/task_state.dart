part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> pendingtask;
  final List<Task> completetask;
  final List<Task> favoritetask;
  final List<Task> removetask;
  const TaskState({
    this.pendingtask = const <Task>[],
    this.removetask = const <Task>[],
    this.completetask = const <Task>[],
    this.favoritetask = const <Task>[],
  });

  @override
  List<Object> get props =>
      [pendingtask, removetask, completetask, favoritetask];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'alltask': pendingtask.map((x) => x.toMap()).toList(),
      'removetask': removetask.map((x) => x.toMap()).toList(),
      'completetask': completetask.map((x) => x.toMap()).toList(),
      'favoritetask': favoritetask.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      pendingtask: List<Task>.from(
        (map['alltask'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      removetask: List<Task>.from(
        (map['removetask'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      completetask: List<Task>.from(
        (map['completetask'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      favoritetask: List<Task>.from(
        (map['favoritetask'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskState.fromJson(String source) =>
      TaskState.fromMap(json.decode(source) as Map<String, dynamic>);
}
