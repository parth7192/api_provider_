import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePageController extends ChangeNotifier {
  final String apiLink = "https://jsonplaceholder.typicode.com/posts";

  List<dynamic> _posts = [];
  bool isLoading = false;

  List<dynamic> get posts => _posts;

  HomePageController() {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiLink));
      if (response.statusCode == 200) {
        _posts = jsonDecode(response.body);
      } else {
        _posts = [];
      }
    } catch (e) {
      _posts = [];
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
