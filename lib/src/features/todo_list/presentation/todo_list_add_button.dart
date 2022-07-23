import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_add_controller.dart';
import 'package:mytodo_app/src/shared/components/custom_alert_dialog.dart';

class TodoListAdd extends ConsumerStatefulWidget {
  const TodoListAdd({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoListAddState();
}

class _TodoListAddState extends ConsumerState<TodoListAdd> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Todo? createTodo = await showGeneralDialog<Todo>(
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
              return const CustomAlertDialog(
                title: "Create Todo",
              );
            });
        if (createTodo != null) {
          ref
              .read(todoListAddControllerProvider.notifier)
              .addTodoList(createTodo);
        }
      },
      elevation: 0.0,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: AppColors.tertiaryPink.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
