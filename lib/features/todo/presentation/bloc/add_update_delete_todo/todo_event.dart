part of 'todo_bloc.dart';

abstract class AddUpdateDeleteEvent extends Equatable {
  const AddUpdateDeleteEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends AddUpdateDeleteEvent {
  final TodoEntity todo;

  const AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends AddUpdateDeleteEvent {
  final TodoEntity todo;
  final bool isDone;

  const UpdateTodoEvent({required this.todo, required this.isDone});

  @override
  List<Object> get props => [todo, isDone];
}

// class CheckMarkEvent extends AddUpdateDeleteEvent {
//   final TodoEntity todo;
//   final bool isDone;

//   const CheckMarkEvent({required this.todo, required this.isDone});

//   @override
//   List<Object> get props => [todo, isDone];
// }

class DeleteTodoEvent extends AddUpdateDeleteEvent {
  final TodoEntity todo;

  const DeleteTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
