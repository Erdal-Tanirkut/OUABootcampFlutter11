import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:muse/views/add_post/add_post_state.dart';
import 'package:muse/views/add_post/add_post_view.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Add Post Page',
      home: ChangeNotifierProvider(
        create: (_) => AddPostState(),
        child: AddPostView(),
      ),
    );
  }
}
