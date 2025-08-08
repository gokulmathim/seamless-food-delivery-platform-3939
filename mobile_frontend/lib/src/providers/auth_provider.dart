import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
/// AuthProvider handles user authentication and registration state.
class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _userId;
  String? _userName;
  bool get isAuthenticated => _token != null;

  String? get token => _token;
  String? get userId => _userId;
  String? get userName => _userName;

  // Dummy local example; in a real app, use API
  // PUBLIC_INTERFACE
  Future<bool> login(String email, String password) async {
    // TODO: Call backend API, save token
    _token = "demo_token";
    _userId = "user_001";
    _userName = "Demo User";
    notifyListeners();
    return true;
  }

  // PUBLIC_INTERFACE
  Future<bool> register(String name, String email, String password) async {
    // TODO: Call backend API for registration
    _token = "demo_token";
    _userId = "user_001";
    _userName = name;
    notifyListeners();
    return true;
  }

  // PUBLIC_INTERFACE
  void logout() {
    _token = null;
    _userId = null;
    _userName = null;
    notifyListeners();
  }
}
