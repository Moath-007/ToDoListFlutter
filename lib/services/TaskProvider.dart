import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/TaskModel.dart';

class TaskProvider with ChangeNotifier {
  static const String baseUrl = "http://localhost/ToDoList";

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  Future<void> fetchTasks(String userId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/ReadTasks.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user_id": userId}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          List list = data['data'];
          _tasks = list.map((item) => TaskModel.fromJson(item)).toList();
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<bool> addTask(String title, String desc, String userId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/NewTask.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": title, "description": desc, "user_id": userId}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          await fetchTasks(userId);
          return true;
        }
      }
    } catch (e) { print(e); }
    return false;
  }

  Future<bool> updateTask(String taskId, String title, String desc, String userId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/UpdateTask.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"task_id": taskId, "title": title, "description": desc}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          await fetchTasks(userId);
          return true;
        }
      }
    } catch (e) { print(e); }
    return false;
  }

  Future<bool> deleteTask(String taskId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/DeleteTask.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"task_id": taskId}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          await fetchTasks(taskId);
          return true;
        }
      }
    } catch (e) { print(e); }
    return false;
  }
}