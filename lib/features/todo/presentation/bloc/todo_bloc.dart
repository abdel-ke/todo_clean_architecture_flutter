import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/todo/domain/entities/todo_entity.dart';
import 'package:todo/features/todo/domain/usecases/todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodoUseCase todoUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  TodoBloc(
      {required this.todoUseCase,
      required this.addTodoUseCase,
      required this.updateTodoUseCase,
      required this.deleteTodoUseCase})
      : super(TodoInitialState()) {
    on<TodoEvent>(
      (event, emit) async {
        if (event is GetAllTodosEvent) {
          await _gelAllTodoEventImpl(emit);
        }
        if (event is AddTodoEvent) {
          await _addTodoEventImpl(emit, event);
        }
        if (event is UpdateTodoEvent) {
          await _updateTodoEventImpl(event, emit);
        }
        if (event is DeleteTodoEvent) {
          await _deleteTodoEventImpl(emit, event);
        }
      },
    );
  }

  Future<void> _deleteTodoEventImpl(
      Emitter<TodoState> emit, DeleteTodoEvent event) async {
    emit(LoadingState());
    final failureOeAddTodo = await deleteTodoUseCase(event.todo);
    emit(
      failureOeAddTodo.fold(
        (failure) {
          switch (failure.runtimeType) {
            case DeleteTodoFailure:
              return const ErrorState(message: 'failure to delete this one');
            default:
              return const ErrorState(
                  message: 'other failure from deletTodo event');
          }
        },
        (_) {
          add(GetAllTodosEvent());
          return DeletedState();
        },
      ),
    );
  }

  Future<void> _updateTodoEventImpl(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    // emit(LoadingState());
    final failureOeAddTodo = await updateTodoUseCase(event.todo, event.isDone);
    emit(
      failureOeAddTodo.fold(
        (failure) {
          switch (failure.runtimeType) {
            case UpdateTodoFailure:
              return const ErrorState(message: 'failure to update this one');
            default:
              return const ErrorState(
                  message: 'other failure from updateTodo event');
          }
        },
        (_) {
          // add(GetAllTodosEvent());
          return UpdatedState();
        },
      ),
    );
  }

  Future<void> _addTodoEventImpl(
      Emitter<TodoState> emit, AddTodoEvent event) async {
    emit(LoadingState());
    final failureOeAddTodo = await addTodoUseCase.call(event.todo);
    emit(failureOeAddTodo.fold((failure) {
      switch (failure.runtimeType) {
        case AddTodoFailure:
          return const ErrorState(message: 'failure to add One');
        default:
          return const ErrorState(message: 'other failure from addTodo event');
      }
    }, (_) {
      add(GetAllTodosEvent());
      return AddedState();
    }));
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
}
