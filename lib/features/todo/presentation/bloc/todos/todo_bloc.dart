import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/usecases/todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodoUseCase todoUseCase;
  final CheckMarkTodoUseCase checkMarkTodoUseCase;

  TodoBloc({required this.todoUseCase, required this.checkMarkTodoUseCase})
      : super(TodoInitialState()) {
    on<TodoEvent>(
      (event, emit) async {
        if (event is GetAllTodosEvent) {
          await _gelAllTodoEventImpl(emit);
        }
        if (event is CheckMarkEvent) {
          await _checkMarkTodoEventImpl(event, emit);
        }
      },
    );
  }

  Future<void> _gelAllTodoEventImpl(Emitter<TodoState> emit) async {
    emit(LoadingState());
    final failureOrTodo = await todoUseCase();
    emit(
      failureOrTodo.fold(
        (failure) {
          switch (failure.runtimeType) {
            case AddTodoFailure:
              return const ErrorState(message: 'gel all todo failure');
            default:
              return const ErrorState(message: 'error mn chi haja khra');
          }
        },
        (todo) {
          return LoadedState(todo: todo);
        },
      ),
    );
  }

  Future<void> _checkMarkTodoEventImpl(
      CheckMarkEvent event, Emitter<TodoState> emit) async {
    final failureOeAddTodo =
        await checkMarkTodoUseCase(event.todo, event.isDone);

    emit(
      failureOeAddTodo.fold(
        (failure) {
          switch (failure.runtimeType) {
            case CheckTodoFailure():
              return const ErrorState(message: 'failure to update this one');
            default:
              return const ErrorState(
                  message: 'other failure from updateTodo event');
          }
        },
        (todo) {
          return CheckMarkState(todo: todo);
        },
        // (todo) => CheckMarkState(todo: todo),
      ),
    );
  }
}
