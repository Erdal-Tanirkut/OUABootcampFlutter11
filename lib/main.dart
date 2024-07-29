import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muse/models/comment.dart';
import 'firebase_options.dart';
import 'logger.dart'; // Logger fonksiyonları burada tanımlı olmalı
import 'views/sign_in/sign_in_state.dart'; // SignInState için doğru import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize the FirebaseService
  final firebaseService = FirebaseService();

  /* Register a new user TODO buradan yeni kullanıcılar yaratılabilir
  final newUser = await firebaseService.registerUser('example@example.com', '123123123', 'newuser');
  if (newUser != null) {
    info('New user registered with username: ${newUser.username}');
  } else {
    warning('Failed to register new user');
  }*/

  /* Sign in an existing user

  final signedInUser = await firebaseService.signInUser('example@example.com', '123123123');
  if (signedInUser != null) {
    info('User signed in with username: ${signedInUser.username}');
  } else {
    warning('Failed to sign in user');
  }*/

  //Sign out the current user
  //await firebaseService.signOutUser();

  // Create and write a random post to Firestore
  //await firebaseService.createAndWriteRandomPost();

  // Read and log a post
  // Replace with actual post ID if available

  // Create a new Tag and add to Firestore TODO buradan yeni tag ler yaratılabilir
  //final newTag = Tag(tagId: 'NewTag', postIds: []);
  //await firebaseService.createTag(newTag);

  // Read and log all tags
  //await firebaseService.readAndLogAllTags();

  // Read and log posts by Tag ID
  //await firebaseService.readAndLogPostsByTagId('NewTag');

  // Define the URL of the image to download
  //const imageUrl = 'gs://muse0-6debb.appspot.com/newimage.webp';

  // Download and log the image
  //await firebaseService.downloadAndLogImage(imageUrl);

  // Add a comment to a post and log it
  final comment = Comment(
      commentID: 'comment_02',
      postID: "post_301",
      userID: 'user_001',
      description: 'This is a test comment',
      date: DateTime.now().toString()
  );
  // Write a comment to this post:
  //await firebaseService.addCommentToPostAndLog('post_301', comment);

  // Remove a comment from a post and log it
  //await firebaseService.removeCommentFromPostAndLog('post_301', 'comment_001');


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInState(), // SignInState ana sayfa olarak ayarlandı
    );
  }
}
