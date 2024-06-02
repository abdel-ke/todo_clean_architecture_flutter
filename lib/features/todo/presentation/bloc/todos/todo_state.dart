part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitialState extends TodoState {}

class LoadingState extends TodoState {}

class LoadedState extends TodoState {
  final List<TodoEntity> todo;

  const LoadedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

class CheckMarkState extends TodoState {
  final List<TodoEntity> todo;

  const CheckMarkState({required this.todo});

  @override
  List<Object> get props => [todo];
}

// class CheckMarkState extends TodoState {}

class ErrorState extends TodoState {
  final String message;
  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
