import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/pages/update_delete_page.dart';

class TodoList extends StatelessWidget {
  final List<TodoEntity> todos;
  const TodoList({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UpdateDeletePage(todo: todo),
              ),
            );
          
          },
          title: Text(todo.title),
          subtitle: Text(todo.description),
          trailing: Checkbox(
            value: todo.isDone,
            onChanged: (value) {
              BlocProvider.of<TodoBloc>(context)
                  .add(UpdateTodoEvent(todo: todo, isDone: value!));
            }
          ),
        );
      },
    );
  }
}
