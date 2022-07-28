import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/board_item.dart';

class FavoriteTaskView extends StatelessWidget {
  final List<Map> favoriteTasks ;
  const FavoriteTaskView({Key? key,required this.favoriteTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => BoardItem(task: favoriteTasks[index]),
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      itemCount: favoriteTasks.length,
    );
  }
}
