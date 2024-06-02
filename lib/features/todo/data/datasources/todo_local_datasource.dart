import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/exception.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

abstract class TodoLocalDatasource {
  Future<List<TodoEntity>> getAllTodos();
  Future<Unit> addTodos(TodoEntity todo);
  Future<Unit> updateTodos(TodoEntity todo, Map<String, String> data);
  Future<Unit> deleteTodos(TodoEntity todo);
}

final List<TodoEntity> data = [
  TodoEntity(
    title: "first Todo",
    description: 'this is the first todo create par default',
  ),
];

class TodoLocalDatasourceImpl implements TodoLocalDatasource {
  @override
  Future<List<TodoEntity>> getAllTodos() async {
    await Future.delayed(const Duration(seconds: 1));
    if (data.isNotEmpty) {
      return data;
    }
    throw EmptyTodoException();
  }

  @override
  Future<Unit> addTodos(TodoEntity todo) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      data.add(todo);
      return unit;
    } on AddTodoException {
      throw AddTodoFailure();
    }
  }

  @override
  Future<Unit> updateTodos(TodoEntity todo, Map<String, String> dd) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final int index = data.indexWhere((element) => element.id == todo.id);
      if (index != -1) {
        data[index].title = dd['title']!;
        data[index].description = dd['description']!;
      } else {
        throw UpdateTodoFailure();
      }
      return unit;
      } on UpdateTodoException {
    // } catch (e) {
      throw UpdateTodoFailure();
    }
  }

  @override
  Future<Unit> deleteTodos(TodoEntity todo) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      data.remove(todo);
      return unit;
    } on DeleteTodoException {
      throw DeleteTodoFailure();
    }
  }
}
