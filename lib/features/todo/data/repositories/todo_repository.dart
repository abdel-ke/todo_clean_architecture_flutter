import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDatasource localDatasource;

  TodoRepositoryImpl({required this.localDatasource});

  @override
  Either<Failure, List<TodoEntity>> getAllTodos() {
    try {
      final allTodo = localDatasource.getAllTodos();
      return Right(allTodo);
    } catch (e) {
      return Left(AddTodoFailure());
    }
  }

  @override
  Either<Failure, Unit> addTodos(TodoEntity todo) {
    try {
      final allTodo = localDatasource.addTodos(todo);
      return Right(allTodo);
    } catch (e) {
      return Left(AddTodoFailure());
    }
  }

  @override
  Either<Failure, Unit> updateTodos(TodoEntity todo, bool isDone) {
    try {
      final allTodo = localDatasource.updateTodos(todo, isDone);
      return Right(allTodo);
    } catch (e) {
      return Left(UpdateTodoFailure());
    }
  }

  @override
  Either<Failure, Unit> deleteTodos(TodoEntity todo) {
    try {
      final allTodo = localDatasource.deleteTodos(todo);
      return Right(allTodo);
    } catch (e) {
      return Left(UpdateTodoFailure());
    }
  }
}
