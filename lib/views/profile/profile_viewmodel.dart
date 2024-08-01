import 'package:flutter/material.dart';
import '../../firebase_dao.dart';
import 'profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muse/models/post.dart';


class ProfileViewModel extends ChangeNotifier {
  final ProfileState _state = ProfileState();

  ProfileState get state => _state;

  final FirebaseDao _firebaseDao = FirebaseDao();

  Future<void> fetchUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Kullanıcı bilgilerini getir
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      Map<String, dynamic> userData =
          userDoc.data() as Map<String, dynamic> ?? {};
      _state.userName = userData.containsKey('username')
          ? userData['username'] as String
          : '';
      _state.bio = userData.containsKey('bio') ? userData['bio'] as String : '';
      notifyListeners();

      // Kullanıcının gönderilerini getir
      _firebaseDao.readUserPosts(user.uid).listen((userPosts) {
        _state.userPosts = userPosts;
        _state.worksCount = userPosts.length;
        notifyListeners();
        print(userPosts);
      });
    }
  }
}
