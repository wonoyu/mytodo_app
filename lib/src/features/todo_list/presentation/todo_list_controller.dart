import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_repository.dart';

class TodoListController extends StateNotifier<AsyncValue<List<Todo>>> {
  TodoListController({required this.todoListRepository})
      : super(const AsyncValue.loading()) {
    getTodoList();
  }

  final TodoListRepository todoListRepository;

  Future<void> getTodoList() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(todoListRepository.getTodoListDone);
  }
}

final todoListControllerProvider = StateNotifierProvider.autoDispose<
    TodoListController, AsyncValue<List<Todo>>>((ref) {
  final todoListRepository = ref.watch(todoListRepositoryProvider);
  return TodoListController(todoListRepository: todoListRepository);
});
