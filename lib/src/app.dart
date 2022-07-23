import 'package:flutter/material.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_page.dart';
import 'package:mytodo_app/src/shared/themes.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const TodoListPage(),
    );
  }
}
