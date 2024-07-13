// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muse/views/sign_in/sign_in_view.dart';
import 'firebase_options.dart';
import 'logger.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize the FirebaseService
  final firebaseService = FirebaseService();

  // Create and write a random post to Firestore
  await firebaseService.createAndWriteRandomPost();


  // Rastgele oluşturulan postu oku ve loglaID
  await firebaseService.readAndLogPost('post_635'); // Bu id ile post oku

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInView(),
    );
  }
}


