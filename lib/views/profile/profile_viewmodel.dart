import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_state.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileState _state;
  ProfileViewModel(this._state);

  void fetchUserData() async {
    _state.setLoading(true);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      _state.setUserData(userDoc.data() as Map<String, dynamic>);
    }
    _state.setLoading(false);
  }
}
