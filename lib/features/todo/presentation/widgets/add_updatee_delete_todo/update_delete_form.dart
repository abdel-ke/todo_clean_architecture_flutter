import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';

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
                  todo.title = titleController.text;
                  todo.description = descriptionController.text;
                  BlocProvider.of<TodoBloc>(context)
                      .add(UpdateTodoEvent(todo: todo, isDone: todo.isDone));
                  // final updatedTodo = TodoEntity(
                  //   title: titleController.text,
                  //   description: descriptionController.text,
                  //   isDone: todo.isDone,
                  // );
                  // BlocProvider.of<TodoBloc>(context)
                  //     .add(UpdateTodoEvent(todo: updatedTodo, isDone: updatedTodo.isDone));
                  // Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TodoBloc>(context)
                      .add(DeleteTodoEvent(todo: todo));
                  Navigator.pop(context);
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
