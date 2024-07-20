import 'package:flutter/material.dart';

class SignInViewModel extends ChangeNotifier {
  // Add properties and methods for handling sign-in logic
  String email = '';
  String password = '';

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    // Implement sign-in logic

  }
}