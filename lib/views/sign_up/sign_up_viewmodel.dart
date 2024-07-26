import 'package:flutter/material.dart';
import '../../firebase_dao.dart';

class SignUpViewModel extends ChangeNotifier {
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
    try {
      final user = await FirebaseDao().registerUser(email, password, name);
      if (user != null) {
        // User registered successfully
        // Navigate to another screen or show a success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User registered successfully')));
      } else {
        // Registration failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to register user')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
