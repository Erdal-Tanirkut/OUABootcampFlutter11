import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/comment.dart';
import '../../models/post.dart';


class CommentsViewModel extends ChangeNotifier {
  final TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];
  late final Post post;

  void addComment() {
    if (commentController.text.isNotEmpty) {
      comments.add(
          Comment(
        userID: FirebaseAuth.instance.currentUser.toString(),
        postID: post.postId ,
        commentID: Uuid().v4(),
        date: DateTime.now().toString(),
        description: commentController.text,

      ));
      commentController.clear();
      notifyListeners();
    }
  }


}
