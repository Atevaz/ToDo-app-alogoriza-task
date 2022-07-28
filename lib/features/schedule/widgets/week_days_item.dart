import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class WeekDaysItem extends StatelessWidget {
  const WeekDaysItem( {Key? key,required this.dayOfWeek,required this.backgroundColor, required this.colorOfText}) : super(key: key);

  final DateTime dayOfWeek ;
  final Color? backgroundColor;
  final Color? colorOfText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: backgroundColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateFormat.E().format(dayOfWeek),style: TextStyle(color: colorOfText),textAlign: TextAlign.center,),
          SizedBox(
            height: 3.h,
          ),
          Text(DateFormat.d().format(dayOfWeek),style : TextStyle(color: colorOfText),),
        ],
      ),
    );
  }
}
