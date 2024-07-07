class User {
  final String userId;
  final String email;
  final String username;
  final List<String> postIds;
  final List<String> savedPostIds;

  User({
    required this.userId,
    required this.email,
    required this.username,
    this.postIds = const [],
    this.savedPostIds = const [],
  });
}
