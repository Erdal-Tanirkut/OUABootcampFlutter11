import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muse/models/post.dart';
import 'package:muse/models/tag.dart';
import 'package:muse/models/image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math';

class FirebaseService {
  final CollectionReference postsCollection =
  FirebaseFirestore.instance.collection('posts'); // Replace with your collection name

  // List of predefined tags
  final List<Tag> predefinedTags = [
    Tag(tagId: 'Sculpture', postIds: []),
    Tag(tagId: 'Painting', postIds: []),
    Tag(tagId: 'Digital Illustration', postIds: []),
    Tag(tagId: 'portre', postIds: []),
    // Add more tags as needed
  ];

  // Write a Post to Firestore
  Future<void> writePost(Post post) async {
    try {
      await postsCollection.doc(post.postId).set(post.toJson());
      info('Post written to Firestore with ID: ${post.postId}');
    } on FirebaseException catch (e) {
      error("Error writing post: ${e.message}", e);
    }
  }

  // Read a specific Post by ID from Firestore
  Future<Post?> readPost(String postId) async {
    try {
      final docSnapshot = await postsCollection.doc(postId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          info('Post read from Firestore with ID: $postId');
          return Post.fromJson(data);
        } else {
          warning('Post data is null for ID: $postId');
          return null; // Indicate data is null
        }
      } else {
        warning('Post not found with ID: $postId');
        return null; // Indicate post not found
      }
    } on FirebaseException catch (e) {
      error("Error reading post: ${e.message}", e);
      return null; // Indicate error
    }
  }

  // Function to create a random Post
  Future<void> createAndWriteRandomPost() async {
    final random = Random();
    final postId = 'post_${random.nextInt(1000)}'; // Random post ID

    // Select a random tag from the predefined tags
    final randomTag = predefinedTags[random.nextInt(predefinedTags.length)];

    // Create a random post
    final post = Post(
      postId: postId,
      title: 'Rastgele Başlık ${random.nextInt(100)}',
      description: 'Bu rastgele bir içeriğe sahip bir post.',
      tagId: randomTag,
      storageId: 'storage_${random.nextInt(1000)}',
      youtubeVideoLink: 'https://www.youtube.com/shorts/XGdIpgQOSNc',
      likeCount: random.nextInt(100),
      image: Image(storageId: 'image_${random.nextInt(1000)}', imageUrl: 'https://i.etsystatic.com/9001843/r/il/86a001/4540195690/il_1588xN.4540195690_rghf.jpg'),
    );

    // Write the post to Firestore
    await writePost(post);
  }

  // Function to read a Post by ID and log it
  Future<void> readAndLogPost(String postId) async {
    final post = await readPost(postId);
    if (post != null) {
      info('Retrieved Post: ${post.title}, Description: ${post.description}');
    } else {
      warning('Post not found for ID: $postId');
    }
  }
}

void info(String message) {
  print('[INFO] $message');
}

void debug(String message) {
  print('[DEBUG] $message');
}

void warning(String message) {
  print('[WARNING] $message');
}

void error(String message, [dynamic error, StackTrace? stackTrace]) {
  print('[ERROR] $message'); // Add prefix for clarity
  if (error != null) {
    print('Error: $error');
  }

  if (stackTrace != null) {
    print('Stack Trace:\n$stackTrace');
  }
}
