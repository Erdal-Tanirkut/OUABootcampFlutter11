import 'package:flutter/material.dart';
import 'package:muse/views/my_works/my_works_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artwork App',
      theme: ThemeData(
        primaryColor: const Color(0xFFB71C1C),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyWorksPage(),
    );
  }
}
