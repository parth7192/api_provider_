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
        title: const Text("Api With Provider"),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<HomePageController>(context, listen: false)
                  .initData(context);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Consumer<HomePageController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          if (controller.post == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No data available, Please refresh...",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final post = controller.post!;
          return Column(
            children: [
              Card(
                child: ListTile(
                  leading: Text(post['id'].toString(),
                      style: const TextStyle(fontSize: 22)),
                  title: Text(post['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  subtitle: Text(post['body'],
                      style: const TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Provider.of<HomePageController>(context, listen: false)
                      .clearData(context);
                },
                child: const Text("Data Clear"),
              ),
            ],
          );
        },
      ),
    );
  }
}
