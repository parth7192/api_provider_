import 'package:api_provider/module/homepage/layout/homepage_layout.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomepageView extends StatefulWidget {
  static const routeName = 'HomepageView';
  static const route = '/Homepage';
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return const HomepageLayout();
        },
      ),
    );
  }
}
