part of 'home_layout_cubit.dart';

@immutable
abstract class HomeLayoutState {}

class HomeLayoutInitial extends HomeLayoutState {}

class ChangeColorOfDaysState extends HomeLayoutState {}

class CreateDatabaseSuccessState extends HomeLayoutState {}
class CreateDatabaseErrorState extends HomeLayoutState {}
class OpenDataBaseSuccessState extends HomeLayoutState {}
class OpenDataBaseErrorState extends HomeLayoutState {}

class LoadingDataFromDatabaseState extends HomeLayoutState {}
class GetDataSuccessState extends HomeLayoutState {}
class GetDataErrorState extends HomeLayoutState {}

class InsertTaskIntoDatabaseSuccessState extends HomeLayoutState {}
class InsertTaskIntoDatabaseErrorState extends HomeLayoutState {}

class UpdateTaskSuccessState extends HomeLayoutState {}
class UpdateTaskErrorState extends HomeLayoutState {}

class DeleteTaskSuccessState extends HomeLayoutState {}
class DeleteTaskErrorState extends HomeLayoutState {}

class ChangeValueOfCheckBoxState extends HomeLayoutState {}




