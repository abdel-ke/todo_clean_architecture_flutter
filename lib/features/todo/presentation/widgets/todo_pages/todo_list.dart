import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/bloc/todos/todo_bloc.dart';
import 'package:todo/features/todo/presentation/pages/update_delete_page.dart';

class TodoList extends StatefulWidget {
  final List<TodoEntity> todos;
  const TodoList({super.key, required this.todos});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return _buildTodoList(context);
  }

  Widget _buildTodoList(BuildContext context) {
    if (widget.todos.length <= 0) {
      return const Center(child: Text('No data!!'),);
    }
    return RefreshIndicator(
        onRefresh: () => _handleRefresh(context), child: _listView());
  }

  Future<void> _handleRefresh(BuildContext context) async {
    BlocProvider.of<TodoBloc>(context).add(GetAllTodosEvent());
  }

  ListView _listView() {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (context, index) {
        final todo = widget.todos[index];
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
                setState(() {
                  todo.isDone = value!;
                });
              }),
        );
      },
    );
  }
}
