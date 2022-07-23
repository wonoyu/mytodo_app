import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';
import 'package:mytodo_app/src/features/username_auth/presentation/username_auth_controller.dart';

class CustomAlertDialog extends ConsumerStatefulWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomAlertDialogState();
}

class _CustomAlertDialogState extends ConsumerState<CustomAlertDialog> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _markAsDone = false;

  @override
  Widget build(BuildContext context) {
    final usernameState = ref.watch(usernameAuthControllerProvider);
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppColors.primaryWhite,
                  ),
              controller: _textController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Todo",
              ),
            ),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Checkbox(
                  fillColor: MaterialStateProperty.all(AppColors.primaryBlue),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: _markAsDone,
                  onChanged: (value) {
                    setState(() {
                      _markAsDone = value!;
                    });
                  }),
              const Text("Mark as Done")
            ],
          )
        ],
      ),
      actions: [
        ButtonBar(
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                        context,
                        Todo(
                            status: _markAsDone ? "done" : "not yet",
                            todoText: _textController.text,
                            id: 0,
                            belongTo: usernameState.asData?.value ?? "User"));
                  }
                },
                child: const Text("OK"))
          ],
        ),
      ],
    );
  }
}
