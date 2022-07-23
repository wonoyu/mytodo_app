import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_add_repo.dart';
import 'package:mytodo_app/src/shared/api.dart';
import 'package:http/http.dart' as http;
import 'package:mytodo_app/src/shared/providers.dart';

class TodoListAddRepoImpl implements TodoListAddRepo {
  TodoListAddRepoImpl({required this.api, required this.client});

  final TodoListApi api;
  final http.Client client;

  @override
  Future<ReqRes> addTodoList(Todo todo) async {
    final jsonTodo = todo.toJson();
    final response = await client.post(api.addList(), body: jsonTodo);
    return ReqRes.fromJson(json.decode(response.body));
  }

  @override
  Future<ReqRes> updateTodoListDone(int id) async {
    final response = await client.post(api.updateDone(id));
    return ReqRes.fromJson(json.decode(response.body));
  }

  @override
  Future<ReqRes> updateTodoListNotYet(int id) async {
    final response = await client.post(api.updateNotYet(id));
    return ReqRes.fromJson(json.decode(response.body));
  }
}

final todoListAddRepoImplProvider = Provider<TodoListAddRepo>((ref) {
  final client = ref.read(httpClientProvider);
  final api = ref.read(todoListApiProvider);
  return TodoListAddRepoImpl(client: client, api: api);
});
