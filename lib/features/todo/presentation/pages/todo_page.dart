import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/widgets/loading_widget.dart';
import 'package:todo/features/todo/presentation/bloc/add_update_delete_todo/todo_bloc.dart';
import 'package:todo/features/todo/presentation/bloc/todos/todo_bloc.dart';
import 'package:todo/features/todo/presentation/pages/add_todo.dart';
import 'package:todo/features/todo/presentation/widgets/todo_pages/todo_list.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: buildBody(),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildRefreshButton(context),
        const SizedBox(height: 10),
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'refresh',
      onPressed: () {
        BlocProvider.of<TodoBloc>(context).add(GetAllTodosEvent());
      },
      child: const Icon(Icons.refresh),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'add',
      onPressed: () {
        BlocProvider.of<AddUpdateDeleteBloc>(context).add(LoadingEvent());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const AddTodoPage();
            },
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  BlocBuilder<TodoBloc, TodoState> buildBody() {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return _blocBuilder(context, state);
      },
    );
  }

  Widget _blocBuilder(BuildContext context, TodoState state) {
    debugPrint('_blocBuilder state is ${state.runtimeType}');
    switch (state.runtimeType) {
      case LoadingState:
        return const LoadingWidget();
      case LoadedState:
        return TodoList(todos: (state as LoadedState).todo);
      case ErrorState:
        return Center(
          child: Text((state as ErrorState).message),
        );
      default:
        return const Center(
          child: Text('Loading'),
        );
    }
  }
}
