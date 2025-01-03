import 'package:go_router/go_router.dart';

import 'module/homepage/view/homepage_view.dart';

class AppRoutes {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: HomepageView.route,
        name: HomepageView.routeName,
        builder: (context, state) => const HomepageView(),
      ),
    ],
  );
}
