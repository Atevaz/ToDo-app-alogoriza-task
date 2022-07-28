import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app_algoriza_task/core/cubit/home_layout_cubit.dart';
import 'package:todo_app_algoriza_task/core/router/app_router_names.dart';
import 'package:todo_app_algoriza_task/core/util/widgets/my_app_bar.dart';
import 'package:todo_app_algoriza_task/features/home/pages/all_task_view.dart';
import 'package:todo_app_algoriza_task/features/home/pages/completed_task_view.dart';
import 'package:todo_app_algoriza_task/features/home/pages/favorite_task_view.dart';
import 'package:todo_app_algoriza_task/features/home/pages/uncompleted_task_view.dart';

import '../../../core/util/widgets/my_button.dart';
import '../../schedule/widgets/schedule_task_item.dart';
import '../widgets/board_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: MyAppBar(
                title: 'Board',
                isBack: false,
                isCalender: true,
                isTabBar: true,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 12,
                    child: TabBarView(children: [
                      AllTaskView(alltasks: HomeLayoutCubit.get(context).newTasks),
                      CompletedTaskView(completedTask: HomeLayoutCubit.get(context).completedTasks),
                      UncompletedTaskView(uncompletedTask: HomeLayoutCubit.get(context).uncompletedTask),
                      FavoriteTaskView(favoriteTasks: HomeLayoutCubit.get(context).favoriteTask),
                    ]),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                        text: 'Add a Task',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                               context, AppRouterNames.rAddTaskRoute);
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
