import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/theming.dart';
import '../widgets/dialogs/notification_sheet.dart';
import '../widgets/custom_floating_button.dart';
import '../controllers/party_creator_controller.dart';
import '../controllers/user_controller.dart';
import '../models/friend_invitiation.dart';
import '../models/party_invitation.dart';
import '../models/party_request.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late List<FriendInvitation> friendInvs;
  late List<PartyInvitation> partyInvs;
  late List<PartyRequest> partyReqs;

  @override
  void initState() {
    super.initState();
    friendInvs = [];
    partyInvs = [];
    partyReqs = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      friendInvs = await UserController.friendInvitations();
      partyInvs = await UserController.partyInvitations();
      partyReqs = await PartyCreatorController.joinRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      floatingActionButton: CustomFloatingButton(
        caption: AppLocalizations.of(context)!.markAsRead,
        onTap: () {},
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theming.bgColor,
            surfaceTintColor: Theming.bgColor,
            expandedHeight: 115,
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
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "5 notifications",
                style: TextStyle(
                  color: Theming.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, idx) => _notificationItem(ctx),
              childCount: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom + 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationItem(BuildContext ctx) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: ctx,
          builder: (_) => const NotificationSheet(),
        );
      },
      splashColor: Theming.whiteTone.withOpacity(0.05),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theming.whiteTone.withOpacity(0.05),
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Theming.bgColorLight,
                  backgroundImage: NetworkImage(
                      "https://imgs.search.brave.com/lek-f6DrXwq-rOwULco3qjCi9C7IH6nhTo_pySkwVdM/rs:fit:1067:1200:1/g:ce/aHR0cDovLzQuYnAu/YmxvZ3Nwb3QuY29t/Ly1LUjJrSGY2Mjhm/MC9VeERaYlR4UkJC/SS9BQUFBQUFBQUF3/OC8wd0xJbFpLWFow/US9zMTYwMC8oMStv/ZisyKSthLmpwZw"),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Theming.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theming.bgColor,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(ctx)!.invitationFrom,
                        style: const TextStyle(
                          color: Theming.whiteTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const TextSpan(
                        text: " @Ziemniak",
                        style: TextStyle(
                          color: Theming.greenTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "12 ${AppLocalizations.of(ctx)!.minutesAgo}",
                  style: TextStyle(
                    color: Theming.whiteTone.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
