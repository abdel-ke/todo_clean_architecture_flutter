part of 'todo_bloc.dart';

abstract class AddUpdateDeleteEvent extends Equatable {
  const AddUpdateDeleteEvent();

  @override
  List<Object> get props => [];
}

class LoadingEvent extends AddUpdateDeleteEvent {}
class AddTodoEvent extends AddUpdateDeleteEvent {
  final TodoEntity todo;

  const AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends AddUpdateDeleteEvent {
  final TodoEntity todo;
  final Map<String, String> data;

  const UpdateTodoEvent({required this.todo, required this.data});

  @override
  List<Object> get props => [todo, data];
}

class DeleteTodoEvent extends AddUpdateDeleteEvent {
  final TodoEntity todo;

  const DeleteTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
