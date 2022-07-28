import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_algoriza_task/core/cubit/home_layout_cubit.dart';

class ScheduleTaskItem extends StatelessWidget {
  final Map taskItem;
  Object? statusValue = 'completed';

  ScheduleTaskItem({Key? key, required this.taskItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                color: Color(int.parse(taskItem['color'])),
                borderRadius: BorderRadius.circular(18.r)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${taskItem['startTime']}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Colors.white,
                                  blurRadius: 10,
                                  offset: Offset.zero)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          taskItem['title'],
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                      builder: (context, state) {
                        return PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onSelected: (value) {
                              statusValue = value;
                              if (statusValue == 'delete') {
                                HomeLayoutCubit.get(context)
                                    .deleteData(id: taskItem['id']);

                              } else {
                                HomeLayoutCubit.get(context).updateData(
                                    status: '$statusValue', id: taskItem['id']);
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Text("completed"),
                                  value: "completed",
                                ),
                                PopupMenuItem(
                                  child: Text("favorite"),
                                  value: "favorite",
                                ),
                                PopupMenuItem(
                                  child: Text("Delete"),
                                  value: "delete",
                                ),
                              ];
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
