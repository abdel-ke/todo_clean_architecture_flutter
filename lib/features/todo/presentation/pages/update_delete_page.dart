import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';
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
        if (state is ErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        debugPrint('builder state is ${state.runtimeType}');
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              (state as ErrorState).message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
        // Navigator.pop(context);
        BlocProvider.of<TodoBloc>(context).add(GetAllTodosEvent());
        break;
      case UpdatedState:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Todo updated',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            duration: Duration(milliseconds: 1500),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);
        break;
      case DeletedState:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Todo deleted successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
        Future.delayed(const Duration(milliseconds: 1500));
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
