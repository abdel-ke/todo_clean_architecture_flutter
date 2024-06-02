import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDatasource localDatasource;

  TodoRepositoryImpl({required this.localDatasource});

  @override
  Future<Either<Failure, List<TodoEntity>> >getAllTodos() async {
    try {
      final allTodo = await localDatasource.getAllTodos();
      return Right(allTodo);
    } catch (e) {
      return Left(AddTodoFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addTodos(TodoEntity todo) async {
    try {
      final allTodo = await localDatasource.addTodos(todo);
      return Right(allTodo);
    } catch (e) {
      return Left(AddTodoFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTodos(TodoEntity todo, Map<String, String> data) async {
    try {
      final allTodo = await localDatasource.updateTodos(todo, data);
      return Right(allTodo);
    } catch (e) {
      return Left(UpdateTodoFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTodos(TodoEntity todo) async {
    try {
      final allTodo = await localDatasource.deleteTodos(todo);
      return Right(allTodo);
    } catch (e) {
      return Left(DeleteTodoFailure());
    }
  }
}
