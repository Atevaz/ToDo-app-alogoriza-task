import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_algoriza_task/core/cubit/home_layout_cubit.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  static AddTaskCubit get(context) => BlocProvider.of(context);




  insertIntoDatabase({
    required String title,
    required String deadline,
    required String startTime,
    required String endTime,
    required String remind,
    required String repeat,
    required Database? database ,
    //required String status,
  }) async {
    await database!.transaction(
      (txn) {
        return txn
            .rawInsert(
                'INSERT INTO tasks (title , deadline , startTime , endTime ,remind,repeat, status) VALUES ("$title","$deadline","$startTime","$endTime","$remind","$remind","new")')
            .then((value) {
          print('$value insert successfully');
          emit(InsertTaskIntoDatabaseSuccessState());
          //HomeLayoutCubit.get(context).getDataFromDatabase(database);
        }).catchError((error) {
          emit(InsertTaskIntoDatabaseErrorState());
          print('some error is happend ${error.toString()}');
        });
      },
    );
  }
}
