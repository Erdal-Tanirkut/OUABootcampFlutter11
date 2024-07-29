import 'image.dart';

class UserM {
  final String userId;
  final String email;
  final String username;
  final String? password;
  final List<String> postIds;
  final List<String> savedPostIds;
  final ImageM? profileImage; // New field for profile image

  UserM({
    required this.userId,
    required this.email,
    required this.username,
    this.password,
    this.postIds = const [],
    this.savedPostIds = const [],
    this.profileImage, // New field for profile image
  });

  factory UserM.fromJson(Map<String, dynamic> json) {
    // Validate required fields
    if (json['userId'] == null || json['email'] == null || json['username'] == null) {
      throw ArgumentError('Missing required fields in JSON: userId, email, username');
    }

    return UserM(
      userId: json['userId'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String?,
      postIds: (json['postIds'] as List<dynamic>?)?.cast<String>() ?? const [],
      savedPostIds: (json['savedPostIds'] as List<dynamic>?)?.cast<String>() ?? const [],
      profileImage: json['profileImage'] != null
          ? ImageM.fromJson(json['profileImage'] as Map<String, dynamic>)
          : null, // New field for profile image
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email': email,
    'username': username,
    if (password != null) 'password': password,
    'postIds': postIds,
    'savedPostIds': savedPostIds,
    if (profileImage != null) 'profileImage': profileImage!.toJson(), // New field for profile image
  };
}
