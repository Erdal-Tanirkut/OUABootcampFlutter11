import 'package:flutter/material.dart';
import 'package:muse/firebase_dao.dart';
import 'package:muse/models/post.dart';
import 'explore_state.dart';

class ExploreViewModel extends ChangeNotifier {
  final FirebaseDao _firebaseDao = FirebaseDao();
  ExploreViewModelState _state;

  ExploreViewModel()
      : _state = ExploreViewModelState(
    searchController: TextEditingController(),
    searchQuery: '',
  );

  ExploreViewModelState get state => _state;

  void updateSearchQuery(String query) {
    _state = ExploreViewModelState(
      searchController: _state.searchController,
      searchQuery: query,
      posts: _state.posts,
    );
    notifyListeners();
  }

  void fetchPosts() {
    _firebaseDao.readAllPosts().listen((posts) {
      _state = ExploreViewModelState(
        searchController: _state.searchController,
        searchQuery: _state.searchQuery,
        posts: posts,
      );
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _state.searchController.dispose();
    super.dispose();
  }
}
