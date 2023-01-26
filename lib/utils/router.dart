import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/left_menu.dart';
import '../routes/home_page.dart';
import '../routes/parties_page.dart';
import '../routes/profile_page.dart';
import '../routes/map_page.dart';
import '../widgets/navbar.dart';

var controller = PageController(initialPage: 1);

GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return _ScaffoldWithNavBar(child);
      },
      routes: [
        GoRoute(
          path: "/",
          pageBuilder: (context, state) {
            return pageTransition(
              context: context,
              state: state,
              child: PageView(
                controller: controller,
                physics: const ClampingScrollPhysics(),
                children: const [
                  LeftMenu(),
                  HomePage(),
                ],
              ),
            );
          },
        ),
        GoRoute(
          path: "/parties",
          pageBuilder: (context, state) {
            return pageTransition(
              context: context,
              state: state,
              child: const PartiesPage(),
            );
          },
        ),
        GoRoute(
          path: "/profile",
          pageBuilder: (context, state) {
            return pageTransition(
              context: context,
              state: state,
              child: const ProfilePage(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/map",
      pageBuilder: (context, state) {
        return pageTransition(
          context: context,
          state: state,
          child: const MapPage(),
        );
      },
    ),
  ],
);

class _ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNavBar(this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          child,
          Align(
            alignment: Alignment.bottomCenter,
            child: NavBar(
              bottomMargin: MediaQuery.of(context).padding.bottom + 40,
            ),
          ),
        ],
      ),
    );
  }
}

CustomTransitionPage pageTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 120),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
