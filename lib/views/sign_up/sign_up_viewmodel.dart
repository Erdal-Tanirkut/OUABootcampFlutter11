import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  // Add properties and methods for handling sign-up logic
  String name = '';
  String email = '';
  String password = '';

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    // Implement sign-up logic
  }
}