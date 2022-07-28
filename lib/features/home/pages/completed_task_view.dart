import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/board_item.dart';

class CompletedTaskView extends StatelessWidget {
  final List<Map> completedTask ;
  const CompletedTaskView({Key? key,required this.completedTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => BoardItem(task: completedTask[index]),
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      itemCount: completedTask.length,
    );
  }
}