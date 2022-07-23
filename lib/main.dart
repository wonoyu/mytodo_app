import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/app.dart';
import 'package:mytodo_app/src/features/todo_list/data/todo_list_repository_impl.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_repository.dart';
import 'package:mytodo_app/src/features/todo_list/data/todo_list_add_repo_impl.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_add_repo.dart';

void main() {
  runApp(ProviderScope(overrides: [
    todoListRepositoryProvider
        .overrideWithProvider(todoListRepositoryImplProvider),
    todoListAddRepoProvider.overrideWithProvider(todoListAddRepoImplProvider),
  ], child: const TodoListApp()));
}
