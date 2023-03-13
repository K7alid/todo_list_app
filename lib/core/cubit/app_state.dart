part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeBottomSheetState extends AppState {}

class AddTaskState extends AppState {}

class DeleteTaskState extends AppState {}
