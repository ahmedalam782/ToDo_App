import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app_route/Core/Firebase/firebase_cloud_function.dart';
import 'package:todo_app_route/Models/tasks_model.dart';

import '../../../../Shared/Themes/app_theme.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> addTasks(TaskModel task, String msg) async {
    await FirebaseCloudFunction.addTaskToFirebase(task).timeout(
      const Duration(microseconds: 500),
      onTimeout: () {
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.lightPrimary,
          textColor: AppTheme.black,
          fontSize: 22.0,
        );
      },
    ).catchError(
      (onError) {
        Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.lightPrimary,
          textColor: AppTheme.black,
          fontSize: 22.0,
        );
      },
    );
    getTasks();
    notifyListeners();
  }

  Future<void> getTasks() async {
    List<TaskModel> allTask = await FirebaseCloudFunction.getTaskFromFirebase();
    tasks = allTask
        .where((task) =>
            task.date.day == selectedDate.day &&
            task.date.month == selectedDate.month &&
            task.date.year == selectedDate.year)
        .toList();
    notifyListeners();
  }

  void changeSelectDate(DateTime date) {
    selectedDate = date;
    getTasks();
    notifyListeners();
  }

  updateTaskToDone(TaskModel task) async {
    await FirebaseCloudFunction.updateTaskInFirebase(
      task,
    );
    getTasks();
    notifyListeners();
  }

  updateTask(TaskModel task, String msg) async {
    await FirebaseCloudFunction.updateTaskInFirebase(
      task,
    ).timeout(
      const Duration(microseconds: 500),
      onTimeout: () {
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.lightPrimary,
          textColor: AppTheme.black,
          fontSize: 20.0,
        );
      },
    ).catchError(
      (onError) {
        Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.lightPrimary,
          textColor: AppTheme.black,
          fontSize: 20.0,
        );
      },
    );
    getTasks();
    notifyListeners();
  }

  deleteTask(String id) async {
    await FirebaseCloudFunction.deleteTaskFromFirebase(
      id,
    );
    getTasks();
    notifyListeners();
  }
}
