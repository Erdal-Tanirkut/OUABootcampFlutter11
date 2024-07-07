import 'package:flutter/material.dart';
import 'explore_state.dart';

class ExploreViewModel extends ChangeNotifier {
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
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _state.searchController.dispose();
    super.dispose();
  }
}
