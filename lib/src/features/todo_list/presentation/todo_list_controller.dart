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
    final data = await AsyncValue.guard(todoListRepository.getTodoListDone);
    if (data.asData!.value.length > _unfiltered.length) {
      _unfiltered = data.asData!.value;
      state = AsyncValue.data(_unfiltered);
    }
    state = AsyncValue.data(data.asData!.value);
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

  void reorderTodos(int oldIndex, int newIndex) {
    List<Todo> stateData = state.asData!.value;
    final element = stateData.removeAt(oldIndex);
    stateData.insert(newIndex, element);
    state = AsyncValue.data(stateData);
  }
}

final todoListControllerProvider = StateNotifierProvider.autoDispose<
    TodoListController, AsyncValue<List<Todo>>>((ref) {
  final todoListRepository = ref.watch(todoListRepositoryProvider);
  return TodoListController(todoListRepository: todoListRepository);
});
