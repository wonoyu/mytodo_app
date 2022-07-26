import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_add_repo.dart';

class TodoListAddController extends StateNotifier<AsyncValue<ReqRes?>> {
  TodoListAddController({required this.todoListAddRepo})
      : super(const AsyncData<ReqRes?>(null));

  final TodoListAddRepo todoListAddRepo;

  Future<void> addTodoList(Todo todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => todoListAddRepo.addTodoList(todo));
  }

  Future<void> updateTodoDone(int id) async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => todoListAddRepo.updateTodoListDone(id));
  }

  Future<void> updateTodoNotYet(int id) async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => todoListAddRepo.updateTodoListNotYet(id));
  }

  Future<void> deleteTodo(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => todoListAddRepo.deleteTodo(id));
  }

  Future<void> updateTodoText(String text, int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => todoListAddRepo.updateTodo(text, id));
  }
}

final todoListAddControllerProvider = StateNotifierProvider.autoDispose<
    TodoListAddController, AsyncValue<ReqRes?>>((ref) {
  final todoListAddRepository = ref.watch(todoListAddRepoProvider);
  return TodoListAddController(todoListAddRepo: todoListAddRepository);
});
