import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/usecases/todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class AddUpdateDeleteBloc
    extends Bloc<AddUpdateDeleteEvent, AddUpdateDeleteState> {
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final CheckMarkTodoUseCase checkMarkTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  AddUpdateDeleteBloc(
      {required this.addTodoUseCase,
      required this.updateTodoUseCase,
      required this.checkMarkTodoUseCase,
      required this.deleteTodoUseCase})
      : super(AddUpdateDeleteTodoInitial()) {
    on<AddUpdateDeleteEvent>(
      (event, emit) async {
        if (event is AddTodoEvent) {
          await _addTodoEventImpl(emit, event);
        }
        if (event is UpdateTodoEvent) {
          await _updateTodoEventImpl(event, emit);
        }
        if (event is DeleteTodoEvent) {
          await _deleteTodoEventImpl(emit, event);
        }
        // if (event is CheckMarkEvent) {
        //   await _checkMarkTodoEventImpl(event, emit);
        // }
      },
    );
  }

  Future<void> _addTodoEventImpl(
      Emitter<AddUpdateDeleteState> emit, AddTodoEvent event) async {
    emit(LoadingAddUpdateDeleteState());
    final failureOeAddTodo = await addTodoUseCase.call(event.todo);
    emit(
      failureOeAddTodo.fold(
        (failure) {
          switch (failure.runtimeType) {
            case AddTodoFailure:
              return const ErrorAddUpdateDeleteState(
                  message: 'failure to add One');
            default:
              return const ErrorAddUpdateDeleteState(
                  message: 'other failure from addTodo event');
          }
        },
        (_) {
          return AddedState();
        },
      ),
    );
  }

  Future<void> _updateTodoEventImpl(
      UpdateTodoEvent event, Emitter<AddUpdateDeleteState> emit) async {
    emit(LoadingAddUpdateDeleteState());
    final failureOeAddTodo = await updateTodoUseCase(event.todo);
    emit(
      failureOeAddTodo.fold(
        (failure) {
          switch (failure.runtimeType) {
            case UpdateTodoFailure:
              return const ErrorAddUpdateDeleteState(
                  message: 'failure to update this one');
            default:
              return const ErrorAddUpdateDeleteState(
                  message: 'other failure from updateTodo event');
          }
        },
        (_) {
          return UpdatedState();
        },
      ),
    );
  }

  // Future<void> _checkMarkTodoEventImpl(
  //     CheckMarkEvent event, Emitter<AddUpdateDeleteState> emit) async {
  //   final failureOeAddTodo =
  //       await checkMarkTodoUseCase(event.todo, event.isDone);
  //   emit(
  //     failureOeAddTodo.fold(
  //       (failure) {
  //         switch (failure.runtimeType) {
  //           case CheckTodoFailure():
  //             return const ErrorAddUpdateDeleteState(
  //                 message: 'failure to update this one');
  //           default:
  //             return const ErrorAddUpdateDeleteState(
  //                 message: 'other failure from updateTodo event');
  //         }
  //       },
  //       (_) => CheckMarkState(),
  //     ),
  //   );
  // }

  Future<void> _deleteTodoEventImpl(
      Emitter<AddUpdateDeleteState> emit, DeleteTodoEvent event) async {
    emit(LoadingAddUpdateDeleteState());
    final failureOeAddTodo = await deleteTodoUseCase(event.todo);
    emit(
      failureOeAddTodo.fold(
        (failure) {
          switch (failure.runtimeType) {
            case DeleteTodoFailure:
              return const ErrorAddUpdateDeleteState(
                  message: 'failure to delete this one');
            default:
              return const ErrorAddUpdateDeleteState(
                  message: 'other failure from deletTodo event');
          }
        },
        (_) {
          return DeletedState();
        },
      ),
    );
  }
}
