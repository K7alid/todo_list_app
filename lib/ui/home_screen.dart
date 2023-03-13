import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/cubit/app_cubit.dart';
import 'package:todo_list_app/ui/widgets/custom_text_form_field.dart';
import 'package:todo_list_app/ui/widgets/task_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  void clearText() {
    titleController.clear();
    timeController.clear();
    dateController.clear();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(), //..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state is AddTaskState) {
            Navigator.pop(context);
            clearText();
          }
        },
        builder: (BuildContext context, AppState state) {
          AppCubit taskCubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                'Todo List App',
              ),
            ),
            body: ConditionalBuilder(
              condition: taskCubit.tasks.isEmpty,
              builder: (context) => const Center(
                child: Text(
                  'No tasks added yet',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              fallback: (context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemBuilder: (context, index) => TaskItem(taskCubit, index),
                  itemCount: taskCubit.tasks.length,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (taskCubit.isBottom) {
                  if (formKey.currentState!.validate()) {
                    taskCubit.addTask(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                      isDone: false,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.grey[100],
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomTextFormField(
                                      label: 'Task Title',
                                      prefix: Icons.title,
                                      textInputType: TextInputType.text,
                                      controller: titleController,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'title musn\'t be empty';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  CustomTextFormField(
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeController.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                      label: 'Task Time',
                                      prefix: Icons.watch_later_outlined,
                                      textInputType: TextInputType.datetime,
                                      controller: timeController,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'time musn\'t be empty';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  CustomTextFormField(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(
                                              days: 100,
                                            ),
                                          ),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMMEEEEd()
                                                  .format(value!);
                                        });
                                      },
                                      label: 'Task Date',
                                      prefix: Icons.date_range_outlined,
                                      textInputType: TextInputType.datetime,
                                      controller: dateController,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'date mun\'t be empty';
                                        }
                                        return null;
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    taskCubit.changeBottomSheetState(
                      isOpened: false,
                      icon: Icons.edit,
                    );
                  });
                  taskCubit.changeBottomSheetState(
                    isOpened: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(
                taskCubit.fabIcon,
              ),
            ),
          );
        },
      ),
    );
  }
}
