import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class AddTodoFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UpdateTodoFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyTodoFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class DeleteTodoFailure extends Failure {
  @override
  List<Object?> get props => [];
}
