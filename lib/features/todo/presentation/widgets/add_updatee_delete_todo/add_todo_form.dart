import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/snackbar.dart';
import 'package:todo/core/widgets/loading_widget.dart';
import 'package:todo/core/widgets/my_button.dart';
import 'package:todo/core/widgets/my_textfield.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/bloc/add_update_delete_todo/todo_bloc.dart';
import 'package:todo/features/todo/presentation/pages/todo_page.dart';

class AddTodoForm extends StatelessWidget {
  AddTodoForm({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddUpdateDeleteBloc, AddUpdateDeleteState>(
      builder: (context, state) {
        debugPrint('AddTodoForm builder state is ${state.runtimeType}');
        if (state is AddUpdateDeleteTodoInitial) {
          return _addForm();
        }
        if (state is LoadingAddUpdateDeleteState) {
          return const LoadingWidget();
        }
        if (state is AddedState) {
          return _addForm();
        }
        return const LoadingWidget();
      },
      listener: (context, state) {
        debugPrint('AddTodoForm listener state is ${state.runtimeType}');
        if (state is ErrorAddUpdateDeleteState) {
          showSnackBar(context, state.message, Colors.red);
        }
        if (state is AddedState) {
          showSnackBar(context, 'Todo Aded Successfully', Colors.green);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const TodoPage()),
            (route) => false,
          );
        }
      },
    );
  }

  Padding _addForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(controller: titleController, hintText: 'Title'),
          MyTextField(controller: descriptionController, hintText: 'Description'),
          const SizedBox(
            height: 20,
          ),
          MyButton(onTap: addTodo, title: 'Add Todo')
        ],
      ),
    );
  }

  void addTodo(BuildContext context) {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Please fill all fields',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
    } else {
      BlocProvider.of<AddUpdateDeleteBloc>(context).add(
        AddTodoEvent(
          todo: TodoEntity(
              title: titleController.text,
              description: descriptionController.text),
        ),
      );
    }
  }
}
