// main.dart
import 'package:flutter/material.dart';
import 'package:muse/views/detail/detail_view.dart';
import 'package:muse/views/sign_in/sign_in_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInView(),
    );
  }
}


