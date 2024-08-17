import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/tasks_model.dart';

class FirebaseCloudFunction {
  static CollectionReference<TaskModel> getTaskCollection() =>
      FirebaseFirestore.instance.collection("Tasks").withConverter<TaskModel>(
            fromFirestore: (dcSnapshot, option) =>
                TaskModel.fromJson(dcSnapshot.data()!),
            toFirestore: (taskModel, option) => taskModel.toJson(),
          );

  static Future<void> addTaskToFirebase(TaskModel taskModel) async {
    CollectionReference<TaskModel> collectionReference = getTaskCollection();
    DocumentReference<TaskModel> documentReference = collectionReference.doc();
    taskModel.id = documentReference.id;
    return documentReference.set(taskModel);
  }

  static Future<List<TaskModel>> getTaskFromFirebase() async {
    CollectionReference<TaskModel> collectionReference = getTaskCollection();
    QuerySnapshot<TaskModel> querySnapshot = await collectionReference.get();
    return querySnapshot.docs.map((dcSnapshot) => dcSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirebase(String id) async {
    CollectionReference<TaskModel> collectionReference = getTaskCollection();
    return collectionReference.doc(id).delete();
  }

  static Future<void> updateTaskInFirebase(TaskModel tasks) async {
    CollectionReference<TaskModel> collectionReference = getTaskCollection();
    return collectionReference.doc(tasks.id).update(tasks.toJson());
  }
}
