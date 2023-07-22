import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/login_page.dart';
import '../routes/register_page.dart';
import '../routes/home_page.dart';
import '../routes/parties_users_page.dart';
import '../routes/profile_page.dart';
import '../routes/selected_party_page.dart';
import '../routes/notifications_page.dart';
import '../routes/settings_page.dart';
import '../routes/settings_routes/edit_profile_page.dart';
import '../routes/settings_routes/organization_page.dart';
import '../routes/friend_list.dart';
import '../routes/create_party_page.dart';
import '../routes/settings_routes/party_join_requests_page.dart';
import '../routes/settings_routes/party_participants.dart';
import '../models/party.dart';
import '../models/friend.dart';
import '../models/friend_invitiation.dart';
import '../models/party_invitation.dart';
import '../models/party_request.dart';
import '../widgets/navbar.dart';

//Use this for all routes that does not need NavBar
final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();

//Use this for all routes that need NavBar
final GlobalKey<NavigatorState> _navBarKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: "/login",
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
              childWidget: const PartiesUsersPage(),
            );
          },
        ),
        GoRoute(
          path: "/profile",
          parentNavigatorKey: _navBarKey,
          pageBuilder: (_, state) {
            final Friend? user = state.extra as Friend?;
            return pageTransition(
              state: state,
              childWidget: ProfilePage(user),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/party",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        List<dynamic> params = state.extra as List<dynamic>;
        Party p = params[0];
        bool ableToJoin = params[1];
        return pageTransition(
          state: state,
          childWidget: SelectedPartyPage(
            party: p,
            ableToJoin: ableToJoin,
          ),
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
        final notifs = state.extra as List<List<Object>>;
        final friendInvs = notifs[0] as List<FriendInvitation>;
        final partyInvs = notifs[1] as List<PartyInvitation>;
        final partyReqs = notifs[2] as List<PartyRequest>;
        return pageTransition(
          state: state,
          childWidget: NotificationsPage(
            friendInvs,
            partyInvs,
            partyReqs,
          ),
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
      path: "/create-party",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const CreatePartyPage(),
        );
      },
    ),
    GoRoute(
      path: "/edit-party",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: CreatePartyPage(
            isEdit: true,
            pageToEdit: state.extra as Party,
          ),
        );
      },
    ),
    GoRoute(
      path: "/party-join-requests",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: PartyJoinRequstsPage(state.extra as Party),
        );
      },
    ),
    GoRoute(
      path: "/party-participants",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: PartyParticipantsPage(state.extra as Party),
        );
      },
    ),
    GoRoute(
      path: "/friend-list",
      parentNavigatorKey: _rootKey,
      pageBuilder: (_, state) {
        return pageTransition(
          state: state,
          childWidget: const FriendListPage(),
        );
      },
    ),
  ],
);

CustomTransitionPage pageTransition({
  required GoRouterState state,
  required Widget childWidget,
}) {
  const Duration animDuration = Duration(milliseconds: 100);

  return CustomTransitionPage(
    key: state.pageKey,
    child: childWidget,
    transitionDuration: animDuration,
    reverseTransitionDuration: animDuration,
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
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          child,
          Align(
            alignment: Alignment.bottomCenter,
            child: NavBar(
              bottomMargin: bottomPadding + 30,
            ),
          ),
        ],
      ),
    );
  }
}
