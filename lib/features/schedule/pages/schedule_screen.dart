import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_algoriza_task/core/cubit/home_layout_cubit.dart';
import 'package:todo_app_algoriza_task/core/util/widgets/my_app_bar.dart';
import 'package:todo_app_algoriza_task/features/schedule/widgets/schedule_task_item.dart';

import '../../../core/util/constant/constant.dart';
import '../widgets/week_days_item.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  List<DateTime> daysOfWeek = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 3)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
    DateTime.now().add(const Duration(days: 6)),
  ];

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: MyAppBar(
          title: 'Schedule',
          isBack: true,
          isCalender: false,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
          builder: (context, state) {
            return Column(
              children: [
                BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                  builder: (context, state) {
                    return Container(
                      height: 55.h,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            index == HomeLayoutCubit.get(context).currentIndex
                                ? InkWell(
                                    onTap: () {
                                      HomeLayoutCubit.get(context)
                                          .changeIndex(index);
                                    },
                                    child: WeekDaysItem(
                                      dayOfWeek: daysOfWeek[index],
                                      backgroundColor: Colors.green,
                                      colorOfText: Colors.white,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      HomeLayoutCubit.get(context)
                                          .changeIndex(index);
                                      selectedDate = daysOfWeek[index];
                                      HomeLayoutCubit.get(context)
                                          .filterByDate(daysOfWeek[index]);
                                    },
                                    child: WeekDaysItem(
                                      backgroundColor: Colors.grey[200],
                                      colorOfText: Colors.black,
                                      dayOfWeek: daysOfWeek[index],
                                    ),
                                  ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 5.w,
                        ),
                        itemCount: daysOfWeek.length,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: [
                      Text(
                        DateFormat.EEEE().format(selectedDate),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(DateFormat.yMMMd().format(selectedDate)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 430.h,
                  child: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                    builder: (context, state) {
                      HomeLayoutCubit.get(context)
                          .filterByDate(selectedDate);
                      return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => ScheduleTaskItem(
                            taskItem: HomeLayoutCubit.get(context).tasksPerDate[index]),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5.h,
                        ),
                        itemCount:
                            HomeLayoutCubit.get(context).tasksPerDate.length,
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
