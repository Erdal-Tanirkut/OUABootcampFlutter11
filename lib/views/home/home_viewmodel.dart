import 'package:flutter/material.dart';
import 'home_state.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeState _state;

  HomeViewModel(this._state);

  List<String> get carouselImages => _state.carouselImages;

  void updateImages(List<String> newImages) {
    _state.carouselImages = newImages;
    notifyListeners();
  }
}