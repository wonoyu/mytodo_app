import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_add_controller.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_controller.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_delete_button.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_update_button.dart';
import '../../../shared/extension_async_value.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(todoListAddControllerProvider,
        (_, state) => state.updateTodoSnackbar(context, ref));
    final controller = ref.watch(todoListControllerProvider);
    return controller.when(
      data: (data) {
        return ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              ref
                  .read(todoListControllerProvider.notifier)
                  .reorderTodos(oldIndex, newIndex);
            },
            proxyDecorator: (child, index, animation) {
              return Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.transparent,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              );
            },
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final status = data[index].status == "done" ? true : false;
              return Padding(
                key: ValueKey(data[index].id),
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CheckboxListTile(
                    side: const BorderSide(
                      color: Color(0xffb00bc3),
                    ),
                    contentPadding: const EdgeInsets.all(4.0),
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            data[index].todoText,
                            style: TextStyle(
                                overflow: TextOverflow.fade,
                                decoration: status
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Wrap(
                            spacing: 8.0,
                            children: [
                              TodoListUpdateButton(
                                id: data[index].id,
                                textToEdit: data[index].todoText,
                              ),
                              TodoListDeleteButton(id: data[index].id),
                            ],
                          ),
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor:
                        status ? AppColors.anotherBlue : AppColors.primaryPink,
                    checkColor: AppColors.primaryWhite,
                    value: data[index].status == "not yet" ? false : true,
                    onChanged: (value) {
                      final controllerAddProvider =
                          ref.read(todoListAddControllerProvider.notifier);
                      if (!value!) {
                        controllerAddProvider.updateTodoNotYet(data[index].id);
                      } else {
                        controllerAddProvider.updateTodoDone(data[index].id);
                      }
                    }),
              );
            });
      },
      loading: () => ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) => Container()),
      error: (e, __) => Center(child: Text(e.toString())),
    );
  }
}
