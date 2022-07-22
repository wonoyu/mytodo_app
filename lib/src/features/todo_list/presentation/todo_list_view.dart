import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_controller.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(todoListControllerProvider);
    return controller.when(
      data: (data) {
        return ListView.builder(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final status = data[index].status == "done" ? true : false;
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
                          decoration: status
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor:
                        status ? AppColors.anotherBlue : AppColors.primaryPink,
                    checkColor: AppColors.primaryWhite,
                    value: data[index].status == "not yet" ? false : true,
                    onChanged: (value) {}),
              );
            });
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Center(child: Text(e.toString())),
    );
  }
}
