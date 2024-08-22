import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_route/Core/Firebase/firebase_auth_function.dart';

import '../../Models/tasks_model.dart';

class FirebaseCloudFunction {
  static CollectionReference<TaskModel> getTaskCollection(String uid) =>
      FirebaseAuthFunction.getUsersCollection()
          .doc(uid)
          .collection("Tasks")
          .withConverter<TaskModel>(
            fromFirestore: (dcSnapshot, option) =>
                TaskModel.fromJson(dcSnapshot.data()!),
            toFirestore: (taskModel, option) => taskModel.toJson(),
          );

  static Future<void> addTaskToFirebase(TaskModel taskModel, String uid) async {
    CollectionReference<TaskModel> collectionReference = getTaskCollection(uid);
    DocumentReference<TaskModel> documentReference = collectionReference.doc();
    taskModel.id = documentReference.id;
    return documentReference.set(taskModel);
  }

  static Future<List<TaskModel>> getTaskFromFirebase(String uid) async {
    CollectionReference<TaskModel> collectionReference = getTaskCollection(uid);
    QuerySnapshot<TaskModel> querySnapshot = await collectionReference.get();
    return querySnapshot.docs.map((dcSnapshot) => dcSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirebase(String id, String uid) async {
    CollectionReference<TaskModel> collectionReference = getTaskCollection(uid);
    return collectionReference.doc(id).delete();
  }

  static Future<void> updateTaskInFirebase(TaskModel tasks, String uid) async {
    CollectionReference<TaskModel> collectionReference = getTaskCollection(uid);
    return collectionReference.doc(tasks.id).update(tasks.toJson());
  }
}
