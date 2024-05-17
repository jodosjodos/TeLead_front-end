import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  Map<String, dynamic> _user = {};

  // Getter to access the user data
  Map<String, dynamic> get userData => _user;

  // Method to update the user data and notify listeners
  void updateUser(Map<String, dynamic> user) {
    _user = user;
    notifyListeners();
  }
}
