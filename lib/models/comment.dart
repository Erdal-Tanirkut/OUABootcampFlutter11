class Comment {
  final String commentID;
  final String postID;
  final String userID;
  final String description;
  final String date;

  Comment({
    required this.commentID,
    required this.postID,
    required this.userID,
    required this.description,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    if (json['commentID'] == null ||
        json['postID'] == null ||
        json['userID'] == null ||
        json['description'] == null ||
        json['date'] == null) {
      throw ArgumentError('Missing required fields in JSON');
    }

    return Comment(
      commentID: json['commentID'] as String,
      postID: json['postID'] as String,
      userID: json['userID'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'commentID': commentID,
    'postID': postID,
    'userID': userID,
    'description': description,
    'date': date,
  };
}
