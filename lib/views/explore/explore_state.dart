import 'package:flutter/material.dart';

class ExploreViewModelState {
  final TextEditingController searchController;
  final String searchQuery;

  ExploreViewModelState({
    required this.searchController,
    required this.searchQuery,
  });
}
