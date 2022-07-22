import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/app.dart';
import 'package:mytodo_app/src/features/todo_list/data/todo_list_repository_impl.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mytodo_app/src/shared/api.dart';

void main() {
  runApp(ProviderScope(overrides: [
    todoListRepositoryProvider.overrideWithValue(
        TodoListRepositoryImpl(client: http.Client(), api: TodoListApi()))
  ], child: const TodoListApp()));
}
