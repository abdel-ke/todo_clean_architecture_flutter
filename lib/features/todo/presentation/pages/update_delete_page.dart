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
      builder: (context, state) {
        debugPrint('builder state is ${state.runtimeType}');
        return _builderBlocConsumer(state);
      },
      listener: (context, state) {
        _listenerBlocConsumer(state, context);
      },
    );
  }

  void _listenerBlocConsumer(TodoState state, BuildContext context) {
    debugPrint('listener state is ${state.runtimeType}');
    switch (state.runtimeType) {
      case UpdatedState:
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Todo updated',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
        
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
        // Navigator.pop(context);
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
        return const Center(
          child: Text('ErrorState'),
        );
      default: // LoadedState, UpdatedState
        return UpdateDeleteForm(todo: todo);
    }
  }
}
