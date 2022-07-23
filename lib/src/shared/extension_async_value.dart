import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_controller.dart';

extension AsyncValueUI on AsyncValue {
  void updateTodoSnackbar(BuildContext context, WidgetRef ref) {
    print("kepanggil");
    whenOrNull(data: (data) {
      if (data == null) return null;
      final stateData = data as ReqRes;
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        onVisible: (() =>
            ref.read(todoListControllerProvider.notifier).getTodoList()),
        content: Text(stateData.message),
      ));
    }, error: (e, __) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    });
  }
}
