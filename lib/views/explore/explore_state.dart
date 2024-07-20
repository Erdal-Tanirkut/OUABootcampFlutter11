import 'package:flutter/material.dart';
import 'package:muse/models/post.dart';

class ExploreViewModelState {
  final TextEditingController searchController;
  final String searchQuery;
  final List<Post> posts;

  ExploreViewModelState({
    required this.searchController,
    required this.searchQuery,
    this.posts = const [],
  });
}
