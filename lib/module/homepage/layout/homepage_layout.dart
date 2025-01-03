import 'package:api_provider/controller/homepage_contoller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomepageLayout extends StatelessWidget {
  const HomepageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Posts List"),
      ),
      body: Consumer<HomePageController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          return ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return Card(
                margin: const EdgeInsets.all(16),
                child: ListTile(
                  leading: Text(post['id'].toString(),
                      style: const TextStyle(fontSize: 22)),
                  title: Text(post['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  subtitle:
                      Text(post['body'], style: const TextStyle(color: Colors.grey)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
