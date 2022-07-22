import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_controller.dart';

class CardView extends ConsumerWidget {
  const CardView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(todoListControllerProvider).asData?.value;
    final todoDone =
        data?.where((element) => element.status == "done").length ?? 1;
    final todoNotYet =
        data?.where((element) => element.status == "not yet").length ?? 1;
    return Card(
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$todoNotYet Todos",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.primaryBlueLight),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Not Yet Todos",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$todoDone Todos",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.primaryBlueLight),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Done Todos",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: todoNotYet,
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.primaryPink,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPink.withOpacity(0.6),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: todoDone,
                child: Container(
                  height: 5,
                  color: const Color(0xff3a4876),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
