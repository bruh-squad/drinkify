import 'package:alkoholicy/routes/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        // GoRoute(path: "/parties"),
        // GoRoute(path: "/profile"),
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
          const Align(
            alignment: Alignment.bottomCenter,
            child: NavBar(),
          ),
        ],
      ),
    );
  }
}