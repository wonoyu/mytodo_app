import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/search_widget.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_add_button.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_controller.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_view.dart';
import 'package:mytodo_app/src/features/username_auth/presentation/username_auth_controller.dart';
import 'package:mytodo_app/src/features/username_auth/presentation/username_auth_dialog.dart';
import 'package:mytodo_app/src/shared/components/card_view.dart';
import 'package:mytodo_app/src/shared/components/left_padded_text.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchWidget(),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return RefreshIndicator(
              child: child!,
              onRefresh: () async {
                await ref
                    .read(todoListControllerProvider.notifier)
                    .getTodoList();
              });
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(usernameAuthControllerProvider);
                    return state.maybeWhen(
                        data: (data) => Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8.0,
                              children: [
                                LeftPaddedText(
                                    text: "Welcome, $data!",
                                    style:
                                        Theme.of(context).textTheme.headline5!),
                                ElevatedButton(
                                    onPressed: () =>
                                        setNewUsernameDialog(context, ref),
                                    child: const Text("Change"))
                              ],
                            ),
                        orElse: () => LeftPaddedText(
                            text: "Welcome, User!",
                            style: Theme.of(context).textTheme.headline5!));
                  },
                ),
                const SizedBox(height: 24.0),
                LeftPaddedText(
                    text: "TOTAL TODOS",
                    style: Theme.of(context).textTheme.overline!),
                const SizedBox(
                  height: 16.0,
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        width: 16.0,
                      ),
                      CardView(
                        title: "Not Yet Todos",
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftPaddedText(
                        text: "TODOS LIST",
                        style: Theme.of(context).textTheme.overline!),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const TodoListView(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const TodoListAdd(),
    );
  }

  void setNewUsernameDialog(BuildContext context, WidgetRef ref) async {
    await showGeneralDialog(
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
          return const UsernameAuthDialog();
        });
    ref.read(usernameAuthControllerProvider.notifier).getUsername();
  }
}
