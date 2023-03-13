import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/domain/task_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isBottom = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isOpened,
    required IconData icon,
  }) {
    isBottom = isOpened;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  List<TaskModel> tasks = [];

  void addTask({
    required String title,
    required String time,
    required String date,
    required bool isDone,
  }) {
    tasks.add(TaskModel(
        title: title,
        time: time,
        date: date,
        id: DateTime.now().toString(),
        isDone: isDone));
    emit(AddTaskState());
  }

  void deleteTask(index) {
    tasks.removeAt(index);
    emit(DeleteTaskState());
  }
}
