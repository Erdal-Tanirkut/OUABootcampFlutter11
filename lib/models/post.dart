import 'package:muse/models/tag.dart';
import 'comment.dart';
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
  final ImageM image;
  final String price;  // Yeni eklenen kısım
  final String location;  // Yeni eklenen kısım
  final List<Comment> comments;  // Yeni eklenen kısım

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
    required this.price,
    required this.location,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    if (json['userID'] == null ||
        json['postId'] == null ||
        json['title'] == null ||
        json['description'] == null ||
        json['tagId'] == null ||
        json['storageId'] == null ||
        json['likeCount'] == null ||
        json['image'] == null ||
        json['price'] == null ||  // Yeni eklenen kısım
        json['location'] == null ||  // Yeni eklenen kısım
        json['comments'] == null) {  // Yeni eklenen kısım
      throw ArgumentError('Missing required fields in JSON');
    }

    final tag = Tag.fromJson(json['tagId'] as Map<String, dynamic>);
    final image = ImageM.fromJson(json['image'] as Map<String, dynamic>);
    final comments = (json['comments'] as List<dynamic>)
        .map((commentJson) => Comment.fromJson(commentJson as Map<String, dynamic>))
        .toList();

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
      price: json['price'] as String,  // Yeni eklenen kısım
      location: json['location'] as String,  // Yeni eklenen kısım
      comments: comments,  // Yeni eklenen kısım
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
    'price': price,  // Yeni eklenen kısım
    'location': location,  // Yeni eklenen kısım
    'comments': comments.map((comment) => comment.toJson()).toList(),  // Yeni eklenen kısım
  };
}
