import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/login_page.dart' show LoginPage;
import '../routes/home_page.dart';
import '../routes/parties_page.dart';
import '../routes/profile_page.dart';
import '../routes/edit_profile_page.dart';
import '../routes/create_party_page.dart';
import '../routes/selected_party_page.dart';
import '../routes/settings_page.dart';
import '../routes/notifications_page.dart';

import '../widgets/navbar.dart';

import '../models/party_model.dart';
import '../models/user_model.dart';

//Use this for all routes that does not need NavBar
final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();

//Use this for all routes needing NavBar
final GlobalKey<NavigatorState> _navBarKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: "/",
  routes: [
    ShellRoute(
      navigatorKey: _navBarKey,
      builder: (context, state, child) {
        return _ScaffoldWithNavBar(child);
      },
      routes: [
        GoRoute(
          path: "/",
          parentNavigatorKey: _navBarKey,
          pageBuilder: (context, state) {
            return pageTransition(
              state: state,
              childWidget: const HomePage(),
            );
          },
        ),
        GoRoute(
          path: "/parties",
          parentNavigatorKey: _navBarKey,
          pageBuilder: (context, state) {
            return pageTransition(
              state: state,
              childWidget: const PartiesPage(),
            );
          },
        ),
        GoRoute(
          path: "/edit-profile",
          parentNavigatorKey: _navBarKey,
          pageBuilder: (context, state) {
            return pageTransition(
              state: state,
              childWidget: const EditProfile(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/party",
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) {
        Party p = state.extra as Party;
        return pageTransition(
          state: state,
          childWidget: SelectedPartyPage(party: p),
        );
      },
    ),
    GoRoute(
      path: "/profile",
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) {
        return pageTransition(
          state: state,
          childWidget: ProfilePage(User()),
        );
      },
    ),
    GoRoute(
      path: "/create-party",
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) {
        return pageTransition(
          state: state,
          childWidget: const CreatePartyPage(),
        );
      },
    ),
    GoRoute(
      path: "/login",
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) {
        return pageTransition(
          state: state,
          childWidget: const LoginPage(),
        );
      },
    ),
    GoRoute(
      path: "/notifications",
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) {
        return pageTransition(
          state: state,
          childWidget: const NotificationsPage(),
        );
      },
    ),
    GoRoute(
      path: "/settings",
      parentNavigatorKey: _rootKey,
      pageBuilder: (context, state) {
        return pageTransition(
          state: state,
          childWidget: const SettingsPage(),
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
    reverseTransitionDuration: const Duration(milliseconds: 100),
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
