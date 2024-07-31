import 'package:flutter/material.dart';
import 'comment_model.dart';

class CommentsViewModel extends ChangeNotifier {
  final TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];

  void addComment() {
    if (commentController.text.isNotEmpty) {
      comments.add(Comment(
        username: 'Elif Öztürk',
        profileImage: 'assets/profile_image.jpg',
        timeAgo: 'Just now',
        content: commentController.text,
        likes: 0,
        replies: 0,
      ));
      commentController.clear();
      notifyListeners();
    }
  }

  void likeComment(Comment comment) {
    comment.likes++;
    notifyListeners();
  }
}

