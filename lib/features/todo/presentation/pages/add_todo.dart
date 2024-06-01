import 'package:flutter/material.dart';
import 'package:todo/features/todo/presentation/widgets/add_updatee_delete_todo/add_todo_form.dart';


class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: AddTodoForm(),
    );
  }
}
