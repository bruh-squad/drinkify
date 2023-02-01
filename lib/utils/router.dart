import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/home_page.dart';
import '../routes/parties_page.dart';
import '../routes/profile_page.dart';
import '../routes/map_page.dart';
import '../widgets/navbar.dart';

final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: "/",
  routes: [
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) {
        return _ScaffoldWithNavBar(child);
      },
      routes: [
        GoRoute(
          path: "/",
          pageBuilder: (context, state) {
            return pageTransition(
              state: state,
              childWidget: const HomePage(),
            );
          },
        ),
        GoRoute(
          path: "/parties",
          pageBuilder: (context, state) {
            return pageTransition(
              state: state,
              childWidget: const PartiesPage(),
            );
          },
        ),
        GoRoute(
          path: "/profile",
          pageBuilder: (context, state) {
            return pageTransition(
              state: state,
              childWidget: const ProfilePage(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/map",
      pageBuilder: (context, state) {
        return pageTransition(
          state: state,
          childWidget: const MapPage(),
        );
      },
    ),
  ],
);

CustomTransitionPage pageTransition({
  required GoRouterState state,
  required Widget childWidget,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: childWidget,
    transitionDuration: const Duration(milliseconds: 100),
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class _ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNavBar(this.child);

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          child,
          Align(
            alignment: Alignment.bottomCenter,
            child: NavBar(
              bottomMargin: bottomPadding + 40,
            ),
          ),
        ],
      ),
    );
  }
}
