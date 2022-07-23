import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_repository.dart';

class TodoListController extends StateNotifier<AsyncValue<List<Todo>>> {
  TodoListController({required this.todoListRepository})
      : super(const AsyncValue.loading()) {
    getTodoList();
  }

  final TodoListRepository todoListRepository;
  List<Todo> _unfiltered = [];

  Future<void> getTodoList() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(todoListRepository.getTodoListDone);
    _unfiltered = state.asData!.value;
  }

  void searchTodoList(String keyword) {
    if (state.asData == null) return;
    final todoList = _unfiltered;
    state =
        AsyncValue.data(todoListRepository.searchTodoList(todoList, keyword));
  }

  void cancelSearch() {
    state = AsyncValue.data(_unfiltered);
  }
}

final todoListControllerProvider = StateNotifierProvider.autoDispose<
    TodoListController, AsyncValue<List<Todo>>>((ref) {
  final todoListRepository = ref.watch(todoListRepositoryProvider);
  return TodoListController(todoListRepository: todoListRepository);
});
