import 'dart:convert';

import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mytodo_app/src/shared/api.dart';

class TodoListRepositoryImpl implements TodoListRepository {
  TodoListRepositoryImpl({required this.client, required this.api});

  final http.Client client;
  final TodoListApi api;

  @override
  Future<List<Todo>> getTodoListDone() async {
    final result =
        await Future.wait([getTodoListNotYet(), client.get(api.listDone())]);
    final todosNotYet = result[0] as List<Todo>;
    final response = result[1] as http.Response;
    final responseBody = ReqRes.fromJson(json.decode(response.body));
    todosNotYet.addAll(responseBody.data.todo);
    return todosNotYet;
  }

  @override
  Future<List<Todo>> getTodoListNotYet() async {
    final response = await client.get(api.listNotYet());
    final responseBody = ReqRes.fromJson(json.decode(response.body));
    return responseBody.data.todo;
  }
}
