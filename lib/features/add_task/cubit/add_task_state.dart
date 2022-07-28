part of 'add_task_cubit.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class InsertTaskIntoDatabaseSuccessState extends AddTaskState {}
class InsertTaskIntoDatabaseErrorState extends AddTaskState {}
