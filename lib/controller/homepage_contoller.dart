import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends ChangeNotifier {
  final String apiLink = "https://jsonplaceholder.typicode.com/posts/1";
  final String dbName = "users";

  Map<String, dynamic>? post;
  bool isLoading = false;

  Map<String, dynamic>? get posts => post;

  HomePageController() {
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(dbName);
    if (data != null) {
      post = jsonDecode(data);
    } else {
      post = null;
    }
    notifyListeners();
  }

  Future<void> clearData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    post = null;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Data clear...!!!"),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> initData(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiLink));
      if (response.statusCode == 200) {
        post = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(dbName, jsonEncode(post));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Success....."),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        post = null;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error....!!!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      post = null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Internet Connection...!!!"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
