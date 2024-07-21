import 'package:muse/models/tag.dart';
import 'image.dart';

class Post {
  final String userID;
  final String postId;
  final String title;
  final String description;
  final Tag tagId;
  final String storageId;
  final String youtubeVideoLink;
  final int likeCount;
  final ImageM image; // This is just ID, with this id you can read image from firebaseDAO class (as .webp)

  Post({
    required this.userID,
    required this.postId,
    required this.title,
    required this.description,
    required this.tagId,
    required this.storageId,
    required this.youtubeVideoLink,
    required this.likeCount,
    required this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    if (json['userID'] == null ||
        json['postId'] == null ||
        json['title'] == null ||
        json['description'] == null ||
        json['tagId'] == null ||
        json['storageId'] == null ||
        json['likeCount'] == null ||
        json['image'] == null) {
      throw ArgumentError('Missing required fields in JSON');
    }

    final tag = Tag.fromJson(json['tagId'] as Map<String, dynamic>);
    final image = ImageM.fromJson(json['image'] as Map<String, dynamic>);

    return Post(
      userID: json['userID'] as String,
      postId: json['postId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      tagId: tag,
      storageId: json['storageId'] as String,
      youtubeVideoLink: json['youtubeVideoLink'] as String,
      likeCount: json['likeCount'] as int,
      image: image,
    );
  }

  Map<String, dynamic> toJson() => {
    'userID': userID,
    'postId': postId,
    'title': title,
    'description': description,
    'tagId': tagId.toJson(),
    'storageId': storageId,
    'youtubeVideoLink': youtubeVideoLink,
    'likeCount': likeCount,
    'image': image.toJson(),
  };
}
