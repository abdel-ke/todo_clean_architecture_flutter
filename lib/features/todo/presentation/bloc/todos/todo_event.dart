part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetAllTodosEvent extends TodoEvent {}

class CheckMarkEvent extends TodoEvent {
  final TodoEntity todo;
  final bool isDone;

  const CheckMarkEvent({required this.todo, required this.isDone});

  @override
  List<Object> get props => [todo, isDone];
}
