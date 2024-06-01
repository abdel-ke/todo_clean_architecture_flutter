import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/exception.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';

abstract class TodoLocalDatasource {
  List<TodoEntity> getAllTodos();
  Unit addTodos(TodoEntity todo);
  Unit updateTodos(TodoEntity todo, bool isDone);
  Unit deleteTodos(TodoEntity todo);
}

final List<TodoEntity> data = [
  TodoEntity(
    title: "first Todo",
    description: 'this is the first todo create par default',
  ),
];

class TodoLocalDatasourceImpl implements TodoLocalDatasource {
  @override
  Unit addTodos(TodoEntity todo) {
    try {
      data.add(todo);
      return unit;
    } on AddTodoException {
      throw AddTodoFailure();
    }
  }

  @override
  Unit deleteTodos(TodoEntity todo) {
    try {
      data.remove(todo);
      return unit;
    } on DeleteTodoException {
      throw DeleteTodoFailure();
    }
  }

  @override
  List<TodoEntity> getAllTodos() {
    if (data.isNotEmpty) {
      return data;
    }
    throw EmptyTodoException();
  }

  @override
  Unit updateTodos(TodoEntity todo, bool isDone) {
    try {
      data[data.indexWhere((element) => element.id == todo.id)] = todo;
      return unit;
    } on UpdateTodoException {
      throw UpdateTodoFailure();
    }
  }
}
