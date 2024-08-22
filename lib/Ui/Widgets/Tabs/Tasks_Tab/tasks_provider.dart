import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app_route/Core/Firebase/firebase_cloud_function.dart';
import 'package:todo_app_route/Models/tasks_model.dart';

import '../../../../Shared/Themes/app_theme.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> addTasks(TaskModel task, String msg, String uid) async {
    await FirebaseCloudFunction.addTaskToFirebase(task, uid).then((onValue) {
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.lightPrimary,
        textColor: AppTheme.black,
        fontSize: 22.0,
      );
    }).catchError(
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
    getTasks(uid);
    notifyListeners();
  }

  Future<void> getTasks(String uid) async {
    List<TaskModel> allTask =
        await FirebaseCloudFunction.getTaskFromFirebase(uid);
    tasks = allTask
        .where((task) =>
            task.date.day == selectedDate.day &&
            task.date.month == selectedDate.month &&
            task.date.year == selectedDate.year)
        .toList();
    notifyListeners();
  }

  void changeSelectDate(DateTime date, String uid) {
    selectedDate = date;
    getTasks(uid);
    notifyListeners();
  }

  updateTaskToDone(TaskModel task, String uid) async {
    await FirebaseCloudFunction.updateTaskInFirebase(task, uid);
    getTasks(uid);
    notifyListeners();
  }

  updateTask(TaskModel task, String msg, String uid) async {
    await FirebaseCloudFunction.updateTaskInFirebase(task, uid).then(
      (onValue) {
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
    getTasks(uid);
    notifyListeners();
  }

  deleteTask(String id, String uid) async {
    await FirebaseCloudFunction.deleteTaskFromFirebase(id, uid);
    getTasks(uid);
    notifyListeners();
  }
}
