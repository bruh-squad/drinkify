import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/home_page.dart';
import '../routes/parties_page.dart';
import '../routes/profile_page.dart';
import '../widgets/navbar.dart';

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
            return const MaterialPage(child: HomePage());
          },
        ),
        GoRoute(
          path: "/parties",
          pageBuilder: (context, state) {
            return const MaterialPage(child: PartiesPage());
          },
        ),
        GoRoute(
          path: "/profile",
          pageBuilder: (context, state) {
            return const MaterialPage(child: ProfilePage());
          },
        ),
      ],
    ),
  ],
);

class _ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNavBar(this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          Align(
            alignment: Alignment.bottomCenter,
            child: NavBar(
              bottomMargin: 40 + MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }
}
