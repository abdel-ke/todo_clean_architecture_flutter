import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/snackbar.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/pages/todo_page.dart';
import 'package:todo/features/todo/presentation/widgets/add_updatee_delete_todo/update_delete_form.dart';

class UpdateDeletePage extends StatelessWidget {
  final TodoEntity todo;
  const UpdateDeletePage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: _buildBlocConsumer(),
    );
  }

  BlocConsumer<TodoBloc, TodoState> _buildBlocConsumer() {
    return BlocConsumer<TodoBloc, TodoState>(
      builder: (context, TodoState state) {
        return _builderBlocConsumer(state);
      },
      listener: (context, state) {
        _listenerBlocConsumer(state, context);
      },
    );
  }

  void _listenerBlocConsumer(TodoState state, BuildContext context) async {
    debugPrint('listener state is ${state.runtimeType}');
    switch (state.runtimeType) {
      case ErrorState:
        showSnackBar(context, (state as ErrorState).message, Colors.redAccent);
        // Navigator.pop(context);
        BlocProvider.of<TodoBloc>(context).add(GetAllTodosEvent());
        break;
      case UpdatedState:
        showSnackBar(context, 'Todo updated', Colors.green);
        // await Future.delayed(const Duration(seconds: 2));
        // Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const TodoPage();
        }));
        break;
      case DeletedState:
        showSnackBar(context, 'Todo deleted successfully', Colors.green);
        // Future.delayed(const Duration(milliseconds: 1500));
        Navigator.pop(context);
        break;
      default:
        break;
    }
  }

  Widget _builderBlocConsumer(TodoState state) {
    debugPrint('builder state is ${state.runtimeType}');
    switch (state.runtimeType) {
      case LoadingState:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ErrorState:
        return Center(
          child: Text((state as ErrorState).message),
        );
      default: // LoadedState, UpdatedState
        return UpdateDeleteForm(todo: todo);
    }
  }
}
