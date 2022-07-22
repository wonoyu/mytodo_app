import 'package:flutter/material.dart';
import 'package:mytodo_app/src/constants/colors.dart';
import 'package:mytodo_app/src/features/todo_list/presentation/todo_list_view.dart';
import 'package:mytodo_app/src/shared/components/card_view.dart';
import 'package:mytodo_app/src/shared/components/left_padded_text.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.primaryBlueLight,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeftPaddedText(
                  text: "Welcome, User!",
                  style: Theme.of(context).textTheme.headline5!),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
      ),
    );
  }
}
