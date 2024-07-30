import 'package:flutter/material.dart';
import 'home_state.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeState _state = HomeState();

  HomeState get state => _state;

}
