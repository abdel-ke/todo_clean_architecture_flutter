import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  static int lastId = 0;
  final int? id;
  String title;
  String description;
  bool isDone = false;

  TodoEntity({required this.title, required this.description}): id = ++lastId;

  @override
  List<Object?> get props => [id, title, description, isDone];
}
