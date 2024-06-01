part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetAllTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final TodoEntity todo;

  const AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends TodoEvent {
  final TodoEntity todo;
  final bool isDone;

  const UpdateTodoEvent({required this.todo, required this.isDone});

  @override
  List<Object> get props => [todo, isDone];
}

class DeleteTodoEvent extends TodoEvent {
  final TodoEntity todo;

  const DeleteTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
