import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_add_controller.dart';

class TodoListDeleteButton extends ConsumerWidget {
  const TodoListDeleteButton({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final isDeleted = await showGeneralDialog<bool?>(
            context: context,
            transitionBuilder: (context, anim1, anim2, child) {
              return ScaleTransition(
                scale: Tween(end: 1.0, begin: 1.2).animate(CurvedAnimation(
                    parent: anim1,
                    curve: const Interval(0.50, 1.00, curve: Curves.linear))),
                child: child,
              );
            },
            pageBuilder: (context, anim1, anim2) {
              return AlertDialog(
                title: const Text("Confirm Delete"),
                actions: [
                  ButtonBar(
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text("OK"))
                    ],
                  ),
                ],
              );
            });
        if (isDeleted != null && isDeleted) {
          ref.read(todoListAddControllerProvider.notifier).deleteTodo(id);
        }
      },
      child: const Icon(Icons.delete_outline),
    );
  }
}
