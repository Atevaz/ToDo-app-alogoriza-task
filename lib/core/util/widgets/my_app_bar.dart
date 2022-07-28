import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_algoriza_task/core/cubit/home_layout_cubit.dart';
import 'package:todo_app_algoriza_task/core/router/app_router_names.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final bool isBack;
  final bool isCalender;
  final bool isTabBar;
  final VoidCallback? onPressed;

  const MyAppBar({
    Key? key,
    required this.title,
    this.isBack = false,
    this.isCalender = true,
    this.isTabBar = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBack == true
          ? BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              HomeLayoutCubit.get(context).currentIndex = 0 ; 
              Navigator.pushReplacementNamed(
                  context, AppRouterNames.rHomeRoute);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          );
        },
      )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          letterSpacing: 1.1,
          fontSize: 25.sp,
        ),
      ),
      actions: [
        isCalender == true
            ? Row(
          children: [
            BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AppRouterNames.rScheduleRoute);
                    HomeLayoutCubit.get(context).filterByDate(DateTime.now());
                  },
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                );
              },
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        )
            : Container(),
      ],
      bottom: isTabBar == true
          ? TabBar(
        physics: BouncingScrollPhysics(),

        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Container(
            height: 30.h,
            alignment: Alignment.center,
            child: Text(
              'All',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
                letterSpacing: 1.1,

              ),
            ),
          ),
          Container(
            height: 30.h,
            alignment: Alignment.center,
            child: Text(
              'Completed',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 8.sp,
                letterSpacing: 1.1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 30.h,
            alignment: Alignment.center,
            child: Text(
              'UnCompleted',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 30.h,
            alignment: Alignment.center,
            child: Text(
              'Favorite',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11.sp,
                letterSpacing: 1.1,

              ),
            ),
          ),
        ],
      )
          : null,

    );
  }
}
