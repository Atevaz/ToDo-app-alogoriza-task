import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_algoriza_task/core/cubit/home_layout_cubit.dart';


class BoardItem extends StatelessWidget {

  final Map task;

  BoardItem({Key? key, required this.task}) : super(key: key);
  bool value1 = false;
  Object? statusValue = 'completed';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Transform.scale(
                  //   scale: 1.8,
                  //   child: Checkbox(
                  //     value: value1,
                  //     activeColor: Color(int.parse(task['color'])),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(6.r),
                  //     ),
                  //     side: BorderSide(
                  //         width: .5.w,
                  //         color: Color(int.parse(task['color']))
                  //     ),
                  //     onChanged: (value) {
                  //       // setState(() {
                  //       //   value1 = value!;
                  //       // });
                  //     },
                  //   ),
                  // ),
                  Container(


                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5,vertical: 6),
                      child: Text('${task['startTime']}',style: TextStyle(color: Colors.white),textAlign: TextAlign.center),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Color(int.parse(task['color'])),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(child: Text('${task['title']}', maxLines: 2,
                    overflow: TextOverflow.ellipsis,)),
                  PopupMenuButton(
                      icon: Icon(Icons.more_vert, color: Colors.grey,),
                      onSelected: (value) {
                        statusValue = value;
                        if (statusValue == 'delete') {
                          HomeLayoutCubit.get(context).deleteData(
                              id: task['id']);
                        } else {
                          HomeLayoutCubit.get(context).updateData(
                              status: '$statusValue', id: task['id']);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text("completed"),
                            value: "completed",
                          ),
                          PopupMenuItem(
                            child: Text("uncompleted"),
                            value: "uncompleted",
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
                      })
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
