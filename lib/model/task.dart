import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String title;
  final String id;
  final String description;
  final String date;
  bool? isdone;
  bool? isfavourited;
  bool? isdeleted;

  Task({

    required this.description,
     this.isfavourited,
    required this.date,
    required this.title,
    required this.id,
    this.isdeleted,
    this.isdone,
  }) {
    isdone = isdone ?? false;
     isfavourited = isfavourited ?? false;
    isdeleted = isdeleted ?? false;
  }
  Task copyWith({
    String? title,
    String? data,
    String? description,
    
    String? id,
    bool? isdone,
    bool? isfavourited,
    bool? isdeleted,
  }) {
    return Task(
      description: description ?? this.description,
      date: date ?? this.date,
      isfavourited: isfavourited ?? this.isfavourited,
        title: title ?? this.title,
        id: id ?? this.id,
        isdeleted: isdeleted ?? this.isdeleted,
        isdone: isdone ?? this.isdone);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'isfavourited': isfavourited,
      'isdone': isdone,
      'isdeleted': isdeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
       description: map['description'] ?? '',
       isfavourited: map['isfavourited'] ?? '',
        title: map['title'] ?? '',
        id: map['id'] ?? '',
        date: map['data'] ?? '',
        isdeleted: map['isdeleted'],
        isdone: map['isdone']);
  }

  @override
  List<Object?> get props => [title, isdone, isdeleted,id,description,date,isfavourited];
}
