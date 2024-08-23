import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app_route/Models/auth_error_model.dart';

class ServerException implements Exception {
  final AuthErrorModel errorModel;

  ServerException({required this.errorModel});

  static void handleFirebaseException(FirebaseAuthException e) {
    throw ServerException(
        errorModel: AuthErrorModel.fromFireAuthException(e.code.toString()));
  }
}
