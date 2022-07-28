import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/board_item.dart';

class AllTaskView extends StatelessWidget {

  final List<Map> alltasks ;

  const AllTaskView({Key? key ,required this.alltasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => BoardItem(task: alltasks[index],),
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      itemCount: alltasks.length,
    );
  }
}
