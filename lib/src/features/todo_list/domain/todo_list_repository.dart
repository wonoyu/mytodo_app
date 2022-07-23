import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';

abstract class TodoListRepository {
  Future<List<Todo>> getTodoListNotYet();
  Future<List<Todo>> getTodoListDone();
  List<Todo> searchTodoList(List<Todo> todoList, String keyword);
}

final todoListRepositoryProvider = Provider<TodoListRepository>((ref) {
  throw UnimplementedError();
});
