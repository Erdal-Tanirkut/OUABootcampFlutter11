import 'package:flutter/material.dart';
import '../../models/post.dart';

class ExploreViewModel with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  String _searchQuery = '';
  List<String> _selectedCategories = [];

  String get searchQuery => _searchQuery;
  List<String> get selectedCategories => _selectedCategories;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category); // Deselect category if it's already selected
    } else {
      _selectedCategories.add(category); // Select new category
    }
    notifyListeners();
  }

  List<Post> filterPosts(List<Post> posts) {
    if (_searchQuery.isNotEmpty) {
      posts = posts.where((post) => post.title.contains(_searchQuery)).toList();
    }
    if (_selectedCategories.isNotEmpty) {
      posts = posts.where((post) => _selectedCategories.contains(post.tagId.tagId)).toList();
    }
    return posts;
  }
}
