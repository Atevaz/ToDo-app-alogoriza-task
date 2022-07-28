import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeColorOfDaysState());
  }

  Database? database;

  void createDatabase() async {
    openDatabase(
      'todoApp.db',
      version: 1,
      onCreate: (Database database, int version) {
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT , deadline TEXT , startTime TEXT , endTime TEXT , remind TEXT , repeat TEXT , color TEXT , status TEXT)')
            .then((value) {
          emit(CreateDatabaseSuccessState());
          print('table is created');
        }).catchError((error) {
          emit(CreateDatabaseErrorState());
          print('error when create table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(OpenDataBaseSuccessState());
      getDataFromDatabase(database!);
    }).catchError((error) {
      emit(OpenDataBaseErrorState());
      print(error);
    });
  }

  List<Map> allTasks = [];
  List<Map> newTasks = [];

  List<Map> completedTasks = [];
  List<Map> uncompletedTask = [];
  List<Map> favoriteTask = [];

  void getDataFromDatabase(Database database) {
    emit(LoadingDataFromDatabaseState());

    allTasks = [];
    newTasks = [];
    completedTasks = [];
    uncompletedTask = [];
    favoriteTask = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
          allTasks.add(element);
          print(element);
        } else if (element['status'] == 'completed') {
          completedTasks.add(element);
          allTasks.add(element);
          print(element);
        } else if (element['status'] == 'uncompleted') {
          uncompletedTask.add(element);
          allTasks.add(element);
          print(element);
        } else {
          favoriteTask.add(element);
          allTasks.add(element);
          print(element);
        }
      });
      emit(GetDataSuccessState());
    }).catchError((error) {
      emit(GetDataErrorState());
      print(error);
    });
  }

  insertIntoDatabase({
    required String title,
    required String deadline,
    required String startTime,
    required String endTime,
    required String remind,
    required String repeat,
    required String color,
    //required String status,
  }) async {
    await database!.transaction(
      (txn) {
        return txn
            .rawInsert(
                'INSERT INTO tasks (title , deadline , startTime , endTime , remind , repeat , color , status) VALUES ("$title","$deadline","$startTime","$endTime","$remind","$repeat","$color","new")')
            .then((value) {
          print('$value insert successfully');
          emit(InsertTaskIntoDatabaseSuccessState());
          getDataFromDatabase(database!);
        }).catchError((error) {
          emit(InsertTaskIntoDatabaseErrorState());
          print('some error is happend ${error.toString()}');
        });
      },
    ).then((value) {
      emit(InsertTaskIntoDatabaseSuccessState());
    }).catchError((error) {
      emit(InsertTaskIntoDatabaseErrorState());
      print(error);
    });
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      emit(UpdateTaskSuccessState());
      getDataFromDatabase(database!);
    }).catchError((error) {
      emit(UpdateTaskErrorState());
    });
  }

  void deleteData({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database!);
      emit(DeleteTaskSuccessState());
    }).catchError((error) {
      emit(DeleteTaskErrorState());
    });
  }

  List<Map> tasksPerDate = [];

  void filterByDate(DateTime date) {
    tasksPerDate = newTasks
            .where((element) =>
                element['deadline'] == DateFormat.yMMMd().format(date))
            .toList() +
        uncompletedTask
            .where((element) =>
                element['deadline'] == DateFormat.yMMMd().format(date))
            .toList();
  }
}
