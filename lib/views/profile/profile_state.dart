import 'package:flutter/material.dart';

class ProfileState extends ChangeNotifier {
  // Add properties related to the profile
  bool _isLoading = false;
  Map<String, dynamic>? _userData;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get userData => _userData;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setUserData(Map<String, dynamic> data) {
    _userData = data;
    notifyListeners();
  }
}
