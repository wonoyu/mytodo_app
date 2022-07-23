import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';

abstract class TodoListAddRepo {
  Future<ReqRes> addTodoList(Todo todo);
  Future<ReqRes> updateTodoListDone(int id);
  Future<ReqRes> updateTodoListNotYet(int id);
}

final todoListAddRepoProvider = Provider<TodoListAddRepo>((ref) {
  throw UnimplementedError();
});
