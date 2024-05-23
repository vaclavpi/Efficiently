import 'package:uuid/uuid.dart';

class ToDo {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });

  factory ToDo.create(String title, String description, DateTime dueDate) {
    return ToDo(
      id: Uuid().v4(),
      title: title,
      description: description,
      dueDate: dueDate,
    );
  }

  ToDo copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return ToDo(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
