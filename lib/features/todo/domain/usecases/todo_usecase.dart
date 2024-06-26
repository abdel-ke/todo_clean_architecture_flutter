import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodoUseCase {
  final TodoRepository repository;

  GetAllTodoUseCase({
    required this.repository,
  });

  Future<Either<Failure, List<TodoEntity>>> call() {
    return repository.getAllTodos();
  }
}

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase({
    required this.repository,
  });

  Future<Either<Failure, Unit>> call(TodoEntity todo) {
    return repository.addTodos(todo);
  }
}

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase({
    required this.repository,
  });

  Future<Either<Failure, Unit>> call(TodoEntity todo, Map<String, String> data) {
    return repository.updateTodos(todo, data);
  }
}

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase({
    required this.repository,
  });

  Future<Either<Failure, Unit>> call(TodoEntity todo) {
    return repository.deleteTodos(todo);
  }
}
