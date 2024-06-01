import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  // Future<Either<Failure, List<TodoEntity>>> getAllTodo();
  Either<Failure, List<TodoEntity>> getAllTodos();
  Either<Failure, Unit> addTodos(TodoEntity todo);
  Either<Failure, Unit> updateTodos(TodoEntity todo, bool isDone);
  Either<Failure, Unit> deleteTodos(TodoEntity todo);
}
