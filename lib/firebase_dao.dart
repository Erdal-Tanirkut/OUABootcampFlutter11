import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muse/models/post.dart';
import 'package:muse/models/tag.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';

class FirebaseDao {
  final CollectionReference postsCollection = FirebaseFirestore.instance.collection('posts');
  final CollectionReference tagsCollection = FirebaseFirestore.instance.collection('tags');
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Write a Post to Firestore
  Future<void> writePost(Post post) async {
    try {
      await postsCollection.doc(post.postId).set(post.toJson());
    } on FirebaseException catch (e) {
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
      print("Error reading post: ${e.message}");
      return null;
    }
  }

  // Delete a Post
  Future<void> deletePost(String postId) async {
    try {
      await postsCollection.doc(postId).delete();
    } on FirebaseException catch (e) {
      print("Error deleting post: ${e.message}");
    }
  }

  // Create a new Tag in Firestore
  Future<void> createTag(Tag tag) async {
    try {
      await tagsCollection.doc(tag.tagId).set(tag.toJson());
    } on FirebaseException catch (e) {
      print("Error creating tag: ${e.message}");
    }
  }

  // Read all Tags from Firestore
  Future<List<Tag>> readAllTags() async {
    try {
      final querySnapshot = await tagsCollection.get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Tag.fromJson(data);
        }).toList();
      } else {
        return []; // Return an empty list if no tags found
      }
    } on FirebaseException catch (e) {
      print("Error reading tags: ${e.message}");
      return []; // Return an empty list in case of an error
    }
  }

  // Read Posts by Tag ID
  Future<List<Post>> readPostsByTagId(String tagId) async {
    try {
      final querySnapshot = await postsCollection.where('tagId.tagId', isEqualTo: tagId).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Post.fromJson(data);
        }).toList();
      } else {
        return []; // Return an empty list if no posts found
      }
    } on FirebaseException catch (e) {
      print("Error reading posts by tagId: ${e.message}");
      return []; // Return an empty list in case of an error
    }
  }

  // Upload an image to Firebase Storage and get the URL
  Future<String> uploadImage(String imagePath) async {
    try {
      // Create a reference to the location where you want to upload the image
      final storageRef = storage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.webp');

      // Upload the image file to Firebase Storage
      final uploadTask = storageRef.putFile(File(imagePath));

      // Wait until the upload is complete
      final snapshot = await uploadTask;

      // Get the download URL of the uploaded image
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } on firebase_storage.FirebaseException catch (e) {
      print("Error uploading image: ${e.message}");
      throw Exception("Error uploading image");
    }
  }

  // Download an image from Firebase Storage by its URL
  Future<String> downloadImage(String imageUrl) async {
    try {
      final storageRef = storage.refFromURL(imageUrl);
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } on firebase_storage.FirebaseException catch (e) {
      print("Error downloading image: ${e.message}");
      throw Exception("Error downloading image");
    }
  }

  // Register a new user with email and password
  Future<UserM?> registerUser(String email, String password, String username) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Create a new user document in Firestore
        final userModel = UserM(
          userId: user.uid,
          email: user.email!,
          username: username,
          postIds: [],
          savedPostIds: [],
        );
        await usersCollection.doc(user.uid).set(userModel.toJson());

        return userModel;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      print("Error registering user: ${e.message}");
      return null;
    }
  }

  // Sign in an existing user with email and password
  Future<UserM?> signInUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Retrieve user document from Firestore
        final docSnapshot = await usersCollection.doc(user.uid).get();
        if (docSnapshot.exists) {
          final userData = docSnapshot.data() as Map<String, dynamic>;
          return UserM.fromJson(userData);
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      print("Error signing in user: ${e.message}");
      return null;
    }
  }


  // Sign out the current user
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print("Error signing out user: ${e.message}");
    }
  }

  // Update section TODO this update methods not tested. Delete this todo if they are working...

  // Update a User
  Future<void> updateUser(UserM updatedUser) async {
    try {
      await usersCollection.doc(updatedUser.userId).update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      print("Error updating user: ${e.message}");
    }
  }

  // Update a Post
  Future<void> updatePost(Post updatedPost) async {
    try {
      await postsCollection.doc(updatedPost.postId).update(updatedPost.toJson());
    } on FirebaseException catch (e) {
      print("Error updating post: ${e.message}");
    }
  }

  // Update a Tag
  Future<void> updateTag(Tag updatedTag) async {
    try {
      await tagsCollection.doc(updatedTag.tagId).update(updatedTag.toJson());
    } on FirebaseException catch (e) {
      print("Error updating tag: ${e.message}");
    }
  }

  // Update section TODO this update methods not tested. Delete this todo if they are working...


}
