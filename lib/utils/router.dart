import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/login_page.dart';
import '../routes/register_page.dart';
import '../routes/home_page.dart';
import '../routes/parties_page.dart';
import '../routes/profile_page.dart';
import '../routes/selected_party_page.dart';
import '../routes/notifications_page.dart';
import '../routes/settings_page.dart';
import '../routes/settings_routes/edit_profile_page.dart';
import '../routes/settings_routes/languages_page.dart';
import '../routes/settings_routes/privacy_page.dart';
import '../routes/settings_routes/organization_page.dart';
import '../routes/create_party_routes/choose_location_page.dart';

import '../widgets/navbar.dart';

import '../models/party.dart';
import '../models/user.dart';

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
      builder: (_, __, child) => _ScaffoldWithNavBar(child),
      routes: [
        GoRoute(
          path: "/",
          parentNavigatorKey: _navBarKey,
          pageBuilder: (_, state) {
            return pageTransition(
              state: state,
              childWidget: const HomePage(),
            );
          },
        ),
        GoRoute(
          path: "/parties",
          parentNavigatorKey: _navBarKey,
          pageBuilder: (_, state) {
            return pageTransition(
              state: state,
              childWidget: const PartiesPage(),
            );
          },
        ),
        GoRoute(
          path: "/profile",
          parentNavigatorKey: _navBarKey,
          pageBuilder: (_, state) {
            return pageTransition(
              state: state,
              childWidget: ProfilePage(
                User(
                  dateOfBirth: DateTime.now(),
                  password: "",
                ),
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/party",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        Party p = state.extra as Party;
        return pageTransition(
          state: state,
          childWidget: SelectedPartyPage(party: p),
        );
      },
    ),
    GoRoute(
      path: "/login",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const LoginPage(),
        );
      },
    ),
    GoRoute(
      path: "/register",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const RegisterPage(),
        );
      },
    ),
    GoRoute(
      path: "/notifications",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const NotificationsPage(),
        );
      },
    ),
    GoRoute(
      path: "/settings",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const SettingsPage(),
        );
      },
    ),
    GoRoute(
      path: "/edit-profile",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const EditProfilePage(),
        );
      },
    ),
    GoRoute(
      path: "/organization",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const OrganizationPage(),
        );
      },
    ),
    GoRoute(
      path: "/languages",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const LanguagesPage(),
        );
      },
    ),
    GoRoute(
      path: "/privacy",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const PrivacyPage(),
        );
      },
    ),
    GoRoute(
      //This route is being pushed using Navigator
      path: "/choose-location",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: ChooseLocationPage(
            onSave: (location) {},
          ),
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
