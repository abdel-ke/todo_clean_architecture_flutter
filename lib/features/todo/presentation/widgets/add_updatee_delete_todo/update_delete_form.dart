import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/bloc/add_update_delete_todo/todo_bloc.dart';

class UpdateDeleteForm extends StatelessWidget {
  final TodoEntity todo;
  UpdateDeleteForm({super.key, required this.todo});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // two inputs has the data of the todo
          TextField(
            controller: titleController..text = todo.title,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: descriptionController..text = todo.description,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AddUpdateDeleteBloc>(context).add(
                      UpdateTodoEvent(todo: todo, data: {
                    'title': titleController.text,
                    'description': descriptionController.text
                  }));
                },
                child: const Text('Update'),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AddUpdateDeleteBloc>(context)
                      .add(DeleteTodoEvent(todo: todo));
                },
                child: const Text('Delete'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
