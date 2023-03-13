import 'package:flutter/material.dart';

Widget TaskItem(taskCubit, index) => Card(
      elevation: 4.0,
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 35,
            ),
            onPressed: () {
              taskCubit.deleteTask(index);
            },
          ),
          title: Text(
            taskCubit.tasks[index].title,
            style: const TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskCubit.tasks[index].time,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                taskCubit.tasks[index].date,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
