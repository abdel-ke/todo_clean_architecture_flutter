import 'package:todo/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({required super.title, required super.description});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(title: json['title'], description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description};
  }
}
