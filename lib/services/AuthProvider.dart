import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/UserModel.dart';
class AuthProvider with ChangeNotifier {
  static const String _loginUrl = "http://localhost/ToDoList/login.php";
  static const String _signupUrl = "http://localhost/ToDoList/signup.php";

  UserModel? _user;
  String? _errorMessage;

  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String username, String password) async {
    _errorMessage = null;
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data != null && data['status'] == "success") {
          _user = UserModel.fromJson(data);
          notifyListeners();
          return true;
        } else {

          _errorMessage = data['message'] ?? "Login failed";
          notifyListeners();
          return false;
        }
      } else {
        _errorMessage = "Server Error: ${response.statusCode}";
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "Connection Error: Check your internet";
      notifyListeners();
      print("Login Error: $e");
      return false;
    }
  }


  Future<bool> register(String username, String password) async {
    _errorMessage = null;
    try {
      final response = await http.post(
        Uri.parse(_signupUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == "success") {
        return true;
      } else {
        _errorMessage = data['message'] ?? "Registration failed";
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "Connection Error";
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _user = null;
    _errorMessage = null;
    notifyListeners();
  }
}