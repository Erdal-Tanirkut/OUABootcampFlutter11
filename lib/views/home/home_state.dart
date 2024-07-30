import 'package:flutter/material.dart';
import 'home_viewmodel.dart';

class HomeState extends ChangeNotifier {
  HomeViewModel? _viewModel;

  void update(HomeViewModel viewModel) {
    _viewModel = viewModel;
    notifyListeners();
  }

}
