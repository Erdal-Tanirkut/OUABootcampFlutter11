import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/sign_in/sign_in_viewmodel.dart';
import 'views/sign_in/sign_in_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test SignIn View',
      home: SignInState(),
    );
  }
}
