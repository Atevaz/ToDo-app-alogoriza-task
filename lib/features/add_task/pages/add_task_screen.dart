import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_algoriza_task/core/cubit/home_layout_cubit.dart';
import 'package:todo_app_algoriza_task/core/router/app_router_names.dart';
import 'package:todo_app_algoriza_task/core/util/widgets/my_app_bar.dart';
import 'package:todo_app_algoriza_task/core/util/widgets/my_form_field.dart';
import '../../../core/util/constant/constant.dart';
import '../../../core/util/widgets/my_button.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  Object? selectedValueOfReminder = 'tenMinuteEarlyReminder';
  Object? selectedValueOfRepeater = 'dailyRepeater';





  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var deadlineController =
      TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));
  var endTimeController = TextEditingController(
      text: DateFormat.Hm().format(DateTime.now().add(Duration(hours: 2))));
  var startTimeController =
      TextEditingController(text: DateFormat.Hm().format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    int hourOfAlarm = int.parse(selectedStartTime.format(context).substring(0,2)) ;
    int minutesOfAlarm = int.parse(selectedStartTime.format(context).substring(3,5)) ;
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size(double.infinity, kToolbarHeight),
            child: MyAppBar(
              title: 'Add Task',
              isBack: true,
              isCalender: false,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyFormField(
                      controller: nameController,
                      hintText: 'Design Team Meeting',
                      label: 'Title',
                      keyboardType: TextInputType.text,
                      validatorText: 'title of meeting is required',
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MyFormField(
                      controller: deadlineController,
                      hintText: DateFormat.yMMMd().format(selectedDate),
                      label: 'Deadline',
                      keyboardType: TextInputType.text,
                      validatorText: 'DeadLine of meeting is required',
                      suffixIcon: Icons.keyboard_arrow_down_rounded,
                      onTap: () {
                        pickDate(context).then((value) {
                          deadlineController.text =
                              DateFormat.yMMMd().format(selectedDate);
                        });
                        print(TimeOfDay.now());
                      },
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyFormField(
                            controller: startTimeController,
                            hintText: DateFormat.Hm().format(DateTime.now()),
                            label: 'Start Time',
                            keyboardType: TextInputType.text,
                            validatorText: 'DeadLine of meeting is required',
                            suffixIcon: Icons.access_time,
                            onTap: () {
                              selectStartTime(context).then((value) {
                                startTimeController.text =
                                    selectedStartTime.format(context);
                              });
                            },
                            readOnly: true,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: MyFormField(
                            controller: endTimeController,
                            hintText: DateFormat.Hm().format(DateTime.now()),
                            label: 'End Time',
                            keyboardType: TextInputType.text,
                            validatorText: 'DeadLine of meeting is required',
                            suffixIcon: Icons.access_time,
                            onTap: () {
                              selectEndTime(context).then((value){
                                endTimeController.text = selectedEndTime.format(context);
                              });
                            },
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Remind',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 40.h,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: DropdownButton(
                            alignment: Alignment.centerLeft,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.grey,
                            ),
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Medium',
                            ),
                            underline: Container(),
                            value: selectedValueOfReminder,
                            items: const [
                              DropdownMenuItem(
                                child: Text('10 minutes early'),
                                value: 'tenMinuteEarlyReminder',
                              ),
                              DropdownMenuItem(
                                child: Text('30 minutes early'),
                                value: 'halfHourEarlyReminder',
                              ),
                              DropdownMenuItem(
                                child: Text('An Hour early'),
                                value: 'hourEarlyReminder',
                              ),
                              DropdownMenuItem(
                                child: Text('A day early'),
                                value: 'dayEarlyReminder',
                              )

                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedValueOfReminder = value!;
                                print(value);
                              });
                            }),
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Repeat',
                        style: Theme.of(context).textTheme.headline6),

                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 40.h,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: DropdownButton(
                            alignment: Alignment.centerLeft,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.grey,
                            ),
                            elevation: 16,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Medium',
                            ),
                            underline: Container(),
                            value: selectedValueOfRepeater,
                            items: const [
                              DropdownMenuItem(
                                value: 'dailyRepeater',
                                child: Text('Daily'),
                              ),
                              DropdownMenuItem(
                                value: 'weeklyRepeater',
                                child: Text('Weekly'),
                              ),
                              DropdownMenuItem(
                                value: 'monthlyRepeater',
                                child: Text('Monthly'),
                              ),
                              DropdownMenuItem(
                                value: 'yearlyRepeater',
                                child: Text('Yearly'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedValueOfRepeater = value!;
                                print(value);
                              });
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 130.h,
                    ),
                    //Spacer(),
                    CustomButton(
                        text: 'Create Task',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if(selectedValueOfReminder == 'tenMinuteEarlyReminder'){
                              FlutterAlarmClock.createAlarm(hourOfAlarm,minutesOfAlarm+10,title: nameController.text);
                            }
                            else if(selectedValueOfReminder == 'halfHourEarlyReminder'){
                              FlutterAlarmClock.createAlarm(hourOfAlarm,minutesOfAlarm+30,title: nameController.text);
                            }
                            else if(selectedValueOfReminder == 'hourEarlyReminder'){
                              FlutterAlarmClock.createAlarm(hourOfAlarm+1,minutesOfAlarm,title: nameController.text);
                            }else{
                              FlutterAlarmClock.createAlarm(hourOfAlarm+24,minutesOfAlarm,title: nameController.text);
                            }
                            HomeLayoutCubit.get(context).insertIntoDatabase(
                              title: nameController.text,
                              deadline: deadlineController.text,
                              startTime: startTimeController.text,
                              endTime: endTimeController.text,
                              remind: '$selectedValueOfReminder',
                              repeat: '$selectedValueOfRepeater',
                              color: '${colorsOfTask[Random().nextInt(colorsOfTask.length)]}',
                            );

                            Navigator.pushReplacementNamed(
                                context, AppRouterNames.rHomeRoute);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  pickDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2205),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        print(selectedDate);
      });
    }
  }

  selectStartTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    ) ;
    if (timeOfDay != null && timeOfDay != selectedStartTime) {
      setState(() {
        selectedStartTime = timeOfDay;
        print(selectedStartTime);

      });
    }
  }

  selectEndTime(BuildContext context) async {

    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedEndTime) {
      setState(() {
        selectedEndTime = timeOfDay;
        print(selectedEndTime);
      });
    }
  }
}
