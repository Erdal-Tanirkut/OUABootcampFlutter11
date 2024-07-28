import 'package:flutter/material.dart';

class MyWorksViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> works = [];

  Future<void> fetchWorks() async {
    //fetching data, firebase
    //works
    notifyListeners();
  }
}
}
