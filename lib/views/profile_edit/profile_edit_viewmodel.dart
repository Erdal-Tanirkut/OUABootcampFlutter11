import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/image.dart';
import 'profile_edit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileEditViewModel extends ChangeNotifier {
  final ProfileEditState _state = ProfileEditState();
  ProfileEditState get state => _state;

  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      _state.userName = userDoc.data()?['username'] ?? '';
      _state.email = userDoc.data()?['email'] ?? '';
      _state.location = userDoc.data()?['location'] ?? '';
      _state.photoUrl = userDoc.data()?['photoUrl'] ?? '';
      notifyListeners();
    }
  }

  Future<void> updateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, dynamic> updatedFields = {};

      if (_state.userName.isNotEmpty) updatedFields['username'] = _state.userName;
      if (_state.email.isNotEmpty) updatedFields['email'] = _state.email;
      if (_state.location.isNotEmpty) updatedFields['location'] = _state.location;
      if (_state.photoUrl.isNotEmpty) updatedFields['photoUrl'] = _state.photoUrl;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update(updatedFields);
      if (!disposed) {
        notifyListeners();
      }
    }
  }

  bool disposed = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  void updateUsername(String userName) {
    _state.userName = userName;
    notifyListeners();
  }

  void updateEmail(String email) {
    _state.email = email;
    notifyListeners();
  }

  void updateLocation(String location) {
    _state.location = location;
    notifyListeners();
  }

  void updatePhotoUrl(String filePath) async {
    User? user = FirebaseAuth.instance.currentUser;
    File file = File(filePath);
    try {
      var snapshot = await FirebaseStorage.instance
          .ref('profile_images/${user!.uid}')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      _state.photoUrl = downloadUrl;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'photoUrl': downloadUrl});
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
