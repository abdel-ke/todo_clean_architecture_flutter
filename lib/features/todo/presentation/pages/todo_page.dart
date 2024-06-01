import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/pages/add_todo.dart';
import 'package:todo/features/todo/presentation/widgets/todo_pages/todo_list.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider.value(
                value: BlocProvider.of<TodoBloc>(context),
                child: const AddTodoPage(),
              );
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
        return _blocBuilder(state);
      },
    );
  }

  Widget _blocBuilder(TodoState state) {
    debugPrint('state is ${state.runtimeType}');
    switch (state.runtimeType) {
      case LoadingState:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case LoadedState:
        debugPrint('LoadedState called');
        return TodoList(todos: (state as LoadedState).todo);
      case ErrorState:
        return const Center(
          child: Text('Error'),
        );
      case AddedState:
        return const Center(
          child: Text('Added'),
        );
      default:
        return const Center(
          child: Text('Loading'),
        );
    }
  }
}