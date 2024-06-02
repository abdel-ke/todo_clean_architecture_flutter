import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoEntity>>> getAllTodos();
  Future<Either<Failure, Unit>> addTodos(TodoEntity todo);
  Future<Either<Failure, Unit>> updateTodos(TodoEntity todo, Map<String, String> data);
  Future<Either<Failure, Unit>> deleteTodos(TodoEntity todo);
}
