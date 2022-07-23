import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/app.dart';
import 'package:mytodo_app/src/features/todo_list/data/todo_list_repository_impl.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_repository.dart';
import 'package:mytodo_app/src/features/todo_list/data/todo_list_add_repo_impl.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_add_repo.dart';
import 'package:mytodo_app/src/features/username_auth/data/username_auth_repository_impl.dart';
import 'package:mytodo_app/src/features/username_auth/domain/username_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final sharedPrefs = await initSharedPrefs();
  runApp(ProviderScope(overrides: [
    todoListRepositoryProvider
        .overrideWithProvider(todoListRepositoryImplProvider),
    todoListAddRepoProvider.overrideWithProvider(todoListAddRepoImplProvider),
    usernameAuthRepositoryProvider.overrideWithValue(
        UsernameAuthRepositoryImpl(sharedPreferences: sharedPrefs)),
  ], child: const TodoListApp()));
}

Future<SharedPreferences> initSharedPrefs() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  FlutterNativeSplash.remove();
  return sharedPreferences;
}
