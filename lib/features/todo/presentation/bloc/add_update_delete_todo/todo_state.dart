part of 'todo_bloc.dart';

abstract class AddUpdateDeleteState extends Equatable {
  const AddUpdateDeleteState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeleteTodoInitial extends AddUpdateDeleteState {}

class LoadingAddUpdateDeleteState extends AddUpdateDeleteState {}

class AddedState extends AddUpdateDeleteState {}

class UpdatedState extends AddUpdateDeleteState {}

// class CheckMarkState extends AddUpdateDeleteState {}

class DeletedState extends AddUpdateDeleteState {}

class ErrorAddUpdateDeleteState extends AddUpdateDeleteState {
  final String message;
  const ErrorAddUpdateDeleteState({required this.message});

  @override
  List<Object> get props => [message];
}
