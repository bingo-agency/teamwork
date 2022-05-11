import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  AppState();

  String hometitle = "";

  void setDisplayText(String text) {
    notifyListeners();
  }

  String get getDisplayText => hometitle;
}
