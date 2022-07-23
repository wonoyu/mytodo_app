import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_controller.dart';

class SearchWidget extends ConsumerStatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends ConsumerState<SearchWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoSearchTextField(
        prefixIcon: const Icon(
          CupertinoIcons.search,
          color: AppColors.primaryBlueLight,
        ),
        suffixIcon: const Icon(
          CupertinoIcons.xmark_circle_fill,
          color: AppColors.primaryBlueLight,
        ),
        placeholder: "Search by Title",
        suffixMode: OverlayVisibilityMode.editing,
        onSuffixTap: () {
          setState(() {
            _controller.clear();
            ref.read(todoListControllerProvider.notifier).cancelSearch();
          });
        },
        onChanged: (value) {
          if (value.isEmpty) {
            ref.read(todoListControllerProvider.notifier).cancelSearch();
          }
        },
        controller: _controller,
        onSubmitted: (value) {
          ref.read(todoListControllerProvider.notifier).searchTodoList(value);
        },
      ),
    );
  }
}
