import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:muse/views/add_post/add_post_state.dart';
import 'package:muse/views/add_post/add_post_view.dart';

void main() {
  runApp(TestApp()); //testing add_post screen
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class TestApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Add Post Page',
      navigatorKey: navigatorKey,
      home: ChangeNotifierProvider(
        create: (_) => AddPostState(),
        child: AddPostView(),
      ),
    );
  }
}
