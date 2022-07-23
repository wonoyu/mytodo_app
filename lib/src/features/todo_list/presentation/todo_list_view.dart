import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/todo_list/domain/todo_list_model.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_add_controller.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_controller.dart';
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
    final controllerAdd = ref.watch(todoListAddControllerProvider);
    return controller.when(
      data: (data) {
        return ListView.builder(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final status = data[index].status == "done" ? true : false;
              return ListViewContent(
                  data: data, status: status, index: index, ref: ref);
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

class ListViewContent extends StatelessWidget {
  const ListViewContent(
      {Key? key,
      required this.data,
      required this.status,
      required this.index,
      required this.ref})
      : super(key: key);

  final List<Todo> data;
  final bool status;
  final int index;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: CheckboxListTile(
          side: const BorderSide(
            color: Color(0xffb00bc3),
          ),
          contentPadding: const EdgeInsets.all(4.0),
          title: Text(
            data[index].todoText,
            style: TextStyle(
                decoration:
                    status ? TextDecoration.lineThrough : TextDecoration.none),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: status ? AppColors.anotherBlue : AppColors.primaryPink,
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
  }
}
