import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;

  String description;

  DateTime date;
  bool isDone;

  TaskModel({
    this.id = '',
    required this.title,
    required this.date,
    required this.description,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      date: (json['date'] as Timestamp).toDate(),
      description: json['description'],
      isDone: json['isDone'],
    );
  }

  Map<String, Object?> toJson() => {
        "id": id,
        "title": title,
        "date": Timestamp.fromDate(date),
        "description": description,
        "isDone": isDone,
      };
}
