import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muse/models/post.dart';

class FirebaseDao {
  final CollectionReference postsCollection =
  FirebaseFirestore.instance.collection('posts'); // Replace with your collection name

  // Write a Post to Firestore
  Future<void> writePost(Post post) async {
    try {
      await postsCollection.doc(post.postId).set(post.toJson());
    } on FirebaseException catch (e) {
      // Handle errors appropriately (e.g., logging, throwing exceptions)
      print("Error writing post: ${e.message}");
    }
  }

  // Read all Posts from Firestore (consider pagination for large datasets)
  Stream<List<Post>> readAllPosts() {
    return postsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          return Post.fromJson(data);
        } else {
          // Handle case where data is null (shouldn't normally happen)
          throw Exception("Post data is null");
        }
      }).toList();
    });
  }

  // Read a specific Post by ID from Firestore
  Future<Post?> readPost(String postId) async {
    try {
      final docSnapshot = await postsCollection.doc(postId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          return Post.fromJson(data);
        } else {
          return null; // Indicate data is null
        }
      } else {
        return null; // Indicate post not found
      }
    } on FirebaseException catch (e) {
      // Handle errors appropriately (e.g., logging, throwing exceptions)
      print("Error reading post: ${e.message}");
      return null; // Indicate error
    }
  }

  // Update a Post (assuming you have a method to update specific fields)
  Future<void> updatePost(Post updatedPost) async {
    try {
      await postsCollection.doc(updatedPost.postId).update(updatedPost.toJson());
    } on FirebaseException catch (e) {
      // Handle errors appropriately (e.g., logging, throwing exceptions)
      print("Error updating post: ${e.message}");
    }
  }

  // Delete a Post
  Future<void> deletePost(String postId) async {
    try {
      await postsCollection.doc(postId).delete();
    } on FirebaseException catch (e) {
      // Handle errors appropriately (e.g., logging, throwing exceptions)
      print("Error deleting post: ${e.message}");
    }
  }
}
