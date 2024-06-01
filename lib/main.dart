import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:todo/features/todo/data/repositories/todo_repository.dart';
import 'package:todo/features/todo/domain/usecases/todo_usecase.dart';
import 'package:todo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/todo/presentation/pages/todo_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(
          todoUseCase: GetAllTodoUseCase(
            repository: TodoRepositoryImpl(
              localDatasource: TodoLocalDatasourceImpl(),
            ),
          ),
          addTodoUseCase: AddTodoUseCase(
            repository: TodoRepositoryImpl(
              localDatasource: TodoLocalDatasourceImpl(),
            ),
          ),
          updateTodoUseCase: UpdateTodoUseCase(
            repository: TodoRepositoryImpl(
              localDatasource: TodoLocalDatasourceImpl(),
            ),
          ),
          deleteTodoUseCase: DeleteTodoUseCase(
            repository: TodoRepositoryImpl(
              localDatasource: TodoLocalDatasourceImpl(),
            ),
          ))..add(GetAllTodosEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tdod App',
        home: TodoPage(),
      ),
    );
  }
}
