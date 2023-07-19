import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/notificationspage/category_row.dart';
import '../utils/theming.dart';
import '../models/friend_invitiation.dart';
import '../models/party_invitation.dart';
import '../models/party_request.dart';
import '../routes/notification_routes/party_invitations_page.dart';
import '../routes/notification_routes/party_requests_page.dart';
import './notification_routes/friend_invitations_page.dart';

class NotificationsPage extends StatefulWidget {
  final List<FriendInvitation> friendInvs;
  final List<PartyInvitation> partyInvs;
  final List<PartyRequest> partyReqs;

  const NotificationsPage(
    this.friendInvs,
    this.partyInvs,
    this.partyReqs, {
    super.key,
  });

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              backgroundColor: Theming.bgColor,
              surfaceTintColor: Theming.bgColor,
              expandedHeight: 150,
              pinned: true,
              centerTitle: true,
              shadowColor: Theming.bgColor,
              title: Text(
                AppLocalizations.of(context)!.notificationsNotifications,
                style: const TextStyle(
                  color: Theming.whiteTone,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  backgroundColor: Theming.bgColor,
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Theming.whiteTone,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(54),
                child: CategoryRow(_tabCtrl),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabCtrl,
          children: [
            FriendInvitationsPage(widget.friendInvs),
            PartyInvitationsPage(widget.partyInvs),
            PartyRequestsPage(widget.partyReqs),
          ],
        ),
      ),
    );
  }
}
