import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../models/post.dart';
import '../../models/user.dart';

class MyWorksViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Post> works = [];
  bool isLoading = false;

  Future<void> loadUserData() async {
    try {
      isLoading = true;
      notifyListeners();

      final user = _auth.currentUser;
      if (user == null) return;

      final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (docSnapshot.exists) {
        UserM userModel = UserM.fromJson(docSnapshot.data()!);
        await fetchUserPosts(userModel.savedPostIds);
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserPosts(List<String> savedPostIds) async {
    try {
      List<Post> fetchedWorks = [];
      for (String postId in savedPostIds) {
        final postDoc = await FirebaseFirestore.instance.collection('posts').doc(postId).get();
        if (postDoc.exists) {
          fetchedWorks.add(Post.fromJson(postDoc.data()!));
        }
      }
      works = fetchedWorks;
      notifyListeners();
    } catch (e) {
      print('Error fetching user posts: $e');
    }
  }
}
