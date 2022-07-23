import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/username_auth/presentation/username_auth_controller.dart';

class UsernameAuthDialog extends ConsumerStatefulWidget {
  const UsernameAuthDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UsernameAuthDialogState();
}

class _UsernameAuthDialogState extends ConsumerState<UsernameAuthDialog> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter your username"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          maxLength: 10,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppColors.primaryWhite,
              ),
          controller: _textController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            if (value.length > 10) {
              return 'Maximum length is 10';
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: "User",
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
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(usernameAuthControllerProvider.notifier)
                        .setUsername(_textController.text);
                  }
                  Navigator.pop(context);
                },
                child: const Text("OK"))
          ],
        ),
      ],
    );
  }
}
