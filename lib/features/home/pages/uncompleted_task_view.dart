import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/board_item.dart';

class UncompletedTaskView extends StatelessWidget {
  final List<Map> uncompletedTask ;
  const UncompletedTaskView({Key? key,required this.uncompletedTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => BoardItem(task: uncompletedTask[index]),
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      itemCount: uncompletedTask.length,
    );
  }
}
