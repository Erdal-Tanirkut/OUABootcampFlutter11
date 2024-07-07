import 'dart:ui';

class Post {
  final String postId;
  final String title;
  final String description;
  final String tagId;
  final String storageId;
  final String? youtubeVideoLink;
  final int likeCount;
  final Image image;

  Post({
    required this.postId,
    required this.title,
    required this.description,
    required this.tagId,
    required this.storageId,
    this.youtubeVideoLink,
    required this.likeCount,
    required this.image,
  });
}
