class Comment {
  String username;
  String profileImage;
  String timeAgo;
  String content;
  int likes;
  int replies;

  Comment({
    required this.username,
    required this.profileImage,
    required this.timeAgo,
    required this.content,
    this.likes = 0,
    this.replies = 0,
  });
}

