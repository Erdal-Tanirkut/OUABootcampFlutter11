import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muse/models/post.dart';
import 'package:muse/models/tag.dart';
import 'package:muse/models/image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_dao.dart';
import 'models/user.dart';
import 'package:muse/models/comment.dart';

class FirebaseService {
  final CollectionReference postsCollection =
  FirebaseFirestore.instance.collection('posts');
  final CollectionReference tagsCollection =
  FirebaseFirestore.instance.collection('tags');
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // List of predefined tags
  final List<Tag> predefinedTags = [
    Tag(tagId: 'NewTag', postIds: []),
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
          if (data.containsKey('userID')) {
            return Post.fromJson(data);
          } else {
            warning('userID is missing in Post data for ID: $postId');
            return null;
          }
        } else {
          warning('Post data is null for ID: $postId');
          return null;
        }
      } else {
        warning('Post not found with ID: $postId');
        return null;
      }
    } on FirebaseException catch (e) {
      error("Error reading post: ${e.message}", e);
      return null;
    }
  }

  // Function to create a random Post
  Future<void> createAndWriteRandomPost() async {
    final random = Random();
    final postId = 'post_${random.nextInt(1000)}'; // Random post ID

    final randomTag = predefinedTags[random.nextInt(predefinedTags.length)];

    final post = Post(
      userID: "rastgeleuser1",
      postId: postId,
      title: 'Rastgele Başlık ${random.nextInt(100)}',
      description: 'Bu rastgele bir içeriğe sahip bir post.',
      tagId: randomTag,
      storageId: 'storage_${random.nextInt(1000)}',
      youtubeVideoLink: 'https://www.youtube.com/shorts/XGdIpgQOSNc',
      likeCount: random.nextInt(100),
      image: ImageM(
        storageId: 'image_${random.nextInt(1000)}',
        imageUrl: 'https://i.etsystatic.com/9001843/r/il/86a001/4540195690/il_1588xN.4540195690_rghf.jpg',
        url: '',
        storagePath: '',
      ),
      price: '\$${random.nextInt(100)}',
      location: 'Konum ${random.nextInt(100)}',
      comments: [], artist: 'Erdal Tanırkut',
    );

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

  // Function to create a new Tag in Firestore
  Future<void> createTag(Tag tag) async {
    try {
      await tagsCollection.doc(tag.tagId).set(tag.toJson());
      info('Tag created with ID: ${tag.tagId}');
    } on FirebaseException catch (e) {
      error("Error creating tag: ${e.message}", e);
    }
  }

  // Function to read Posts by Tag ID and log them
  Future<void> readAndLogPostsByTagId(String tagId) async {
    try {
      final querySnapshot = await postsCollection.where('tagId.tagId', isEqualTo: tagId).get();
      if (querySnapshot.docs.isNotEmpty) {
        final posts = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Post.fromJson(data);
        }).toList();

        for (var post in posts) {
          info('Post ID: ${post.postId}, Title: ${post.title}, Description: ${post.description}');
        }
      } else {
        info('No posts found for Tag ID: $tagId');
      }
    } on FirebaseException catch (e) {
      error("Error reading posts by tagId: ${e.message}", e);
    }
  }

  // Function to read all Tags and log them
  Future<void> readAndLogAllTags() async {
    try {
      final tags = await FirebaseDao().readAllTags();
      if (tags.isNotEmpty) {
        for (var tag in tags) {
          info('Tag ID: ${tag.tagId}');
        }
      } else {
        info('No tags found');
      }
    } catch (e) {
      error("Error reading all tags: ${e.toString()}", e);
    }
  }

  // Function to add a Comment to a Post and log it
  Future<void> addCommentToPostAndLog(String postId, Comment comment) async {
    try {
      await FirebaseDao().addCommentToPost(postId, comment);
      info('Comment added to Post ID: $postId, Comment ID: ${comment.commentID}');
    } catch (e) {
      error("Error adding comment to Post ID: $postId", e);
    }
  }

  // Function to remove a Comment from a Post and log it
  Future<void> removeCommentFromPostAndLog(String postId, String commentId) async {
    try {
      await FirebaseDao().removeCommentFromPost(postId, commentId);
      info('Comment removed from Post ID: $postId, Comment ID: $commentId');
    } catch (e) {
      error("Error removing comment from Post ID: $postId", e);
    }
  }

  // Upload an image to Firebase Storage and log the URL
  Future<void> uploadAndLogImage(String imagePath) async {
    try {
      final storageRef = storage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.webp');
      final uploadTask = storageRef.putFile(File(imagePath));
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      info('Image uploaded successfully. Download URL: $downloadUrl');
    } on firebase_storage.FirebaseException catch (e) {
      error("Error uploading image: ${e.message}", e);
    }
  }

  // Download an image from Firebase Storage by its URL and log the URL
  Future<void> downloadAndLogImage(String imageUrl) async {
    try {
      final storageRef = storage.refFromURL(imageUrl);
      final downloadUrl = await storageRef.getDownloadURL();
      info('Image downloaded successfully. Download URL: $downloadUrl');
    } on firebase_storage.FirebaseException catch (e) {
      error("Error downloading image: ${e.message}", e);
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

        info('User registered successfully with ID: ${user.uid}');
        return userModel;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      error("Error registering user: ${e.message}", e);
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
          info('User signed in successfully with ID: ${user.uid}');
          return UserM.fromJson(userData);
        } else {
          warning('User document not found for ID: ${user.uid}');
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      error("Error signing in user: ${e.message}", e);
      return null;
    }
  }

  // Sign out the current user
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
      info('User signed out successfully');
    } on FirebaseAuthException catch (e) {
      error("Error signing out user: ${e.message}", e);
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
