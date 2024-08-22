import 'package:flutter/material.dart';
import 'package:todo_app_route/Models/auth_model.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthModel? currentUser;

  Future<void> updateUser(AuthModel? user) async {
    currentUser = user;
    notifyListeners();
  }
}
