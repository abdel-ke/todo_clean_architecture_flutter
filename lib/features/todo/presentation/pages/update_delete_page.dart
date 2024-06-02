import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/snackbar.dart';
import 'package:todo/core/widgets/loading_widget.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/bloc/add_update_delete_todo/todo_bloc.dart';
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

  BlocConsumer<AddUpdateDeleteBloc, AddUpdateDeleteState> _buildBlocConsumer() {
    return BlocConsumer<AddUpdateDeleteBloc, AddUpdateDeleteState>(
      builder: (context, AddUpdateDeleteState state) {
        return _builderBlocConsumer(state);
      },
      listener: (context, state) {
        _listenerBlocConsumer(state, context);
      },
    );
  }

  void _listenerBlocConsumer(
      AddUpdateDeleteState state, BuildContext context) async {
    debugPrint('listener state is ${state.runtimeType}');
    switch (state.runtimeType) {
      case ErrorAddUpdateDeleteState :
        showSnackBar(context, (state as ErrorAddUpdateDeleteState).message,
            Colors.redAccent);
        break;
      case UpdatedState :
        showSnackBar(context, 'Todo updated', Colors.green);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const TodoPage()),
            (route) => false);
        break;
      case DeletedState :
        showSnackBar(context, 'Todo deleted successfully', Colors.green);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const TodoPage()),
            (route) => false);
        break;
      default:
        break;
    }
  }

  Widget _builderBlocConsumer(AddUpdateDeleteState state) {
    debugPrint('builder state is ${state.runtimeType}');
    switch (state.runtimeType) {
      case LoadingAddUpdateDeleteState :
        return const LoadingWidget();
      default: // LoadedState, UpdatedState
        return UpdateDeleteForm(todo: todo);
    }
  }
}
