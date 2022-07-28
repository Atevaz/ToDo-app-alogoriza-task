import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDropDownMenu extends StatefulWidget {

  final List<DropdownMenuItem<String>>? listOfItems ;
  final void Function(String?) onChange ;
  final String selected ;

  const MyDropDownMenu({super.key,required this.listOfItems,required this.onChange, required this.selected});
  @override
  State<MyDropDownMenu> createState() => _MyDropDownMenuState(listOfItems: this.listOfItems,onChange: this.onChange,selected: this.selected);
}


class _MyDropDownMenuState extends State<MyDropDownMenu> {


  final List<DropdownMenuItem<String>>? listOfItems ;
  final void Function(String?) onChange ;

  _MyDropDownMenuState({ required this.listOfItems,required this.onChange,required this.selected});

  final String selected ;
  final List<String> _items = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: DropdownButton<String>(
          hint: const Text('Select a category'),
          alignment: Alignment.centerLeft,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_downward,
            color: Colors.grey,
          ),
          elevation: 16,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Medium',
          ),
          underline: Container(),
          onChanged: onChange,
          items:listOfItems,

          //DropdownMenuItem<String>(value: 1,child: Text('One day Reminder')),
          //             DropdownMenuItem<String>(value: '${items.oneHourReminder}',child: Text('One Hour Reminder')),
          //             DropdownMenuItem<String>(value: '${items.halfHourReminder}',child: Text('30 minutes Reminder')),
          //             DropdownMenuItem<String>(value: '${items.tenMinutesReminder}',child: Text('10 minutes Reminder')),
        ),
      ),
    );
  }
}
