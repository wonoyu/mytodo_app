import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_add_controller.dart';

class TodoListUpdateButton extends ConsumerStatefulWidget {
  const TodoListUpdateButton(
      {Key? key, required this.id, required this.textToEdit})
      : super(key: key);

  final int id;
  final String textToEdit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListUpdateButtonState();
}

class _TodoListUpdateButtonState extends ConsumerState<TodoListUpdateButton> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final text = await showGeneralDialog<String?>(
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
                title: const Text("Update Text Todo"),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    // maxLength: 10,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppColors.primaryWhite,
                        ),
                    controller: _textController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter some text';
                    //   }
                    //   return null;
                    // },
                    decoration: InputDecoration(
                      hintText: widget.textToEdit,
                    ),
                  ),
                ),
                actions: [
                  ButtonBar(
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context,
                                _textController.text.isEmpty
                                    ? widget.textToEdit
                                    : _textController.text);
                          },
                          child: const Text("OK"))
                    ],
                  ),
                ],
              );
            });
        if (text != null) {
          ref
              .read(todoListAddControllerProvider.notifier)
              .updateTodoText(text, widget.id);
        }
      },
      child: const Icon(Icons.edit_outlined),
    );
  }
}
