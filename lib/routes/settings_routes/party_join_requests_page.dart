import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/party.dart';
import '/utils/theming.dart';
import '/models/party_request.dart';
import '/controllers/party_creator_controller.dart';
import '/widgets/dialogs/notification_sheet.dart';

class PartyJoinRequstsPage extends StatefulWidget {
  final Party party;
  const PartyJoinRequstsPage(
    this.party, {
    super.key,
  });

  @override
  State<PartyJoinRequstsPage> createState() => _PartyJoinRequstsPageState();
}

class _PartyJoinRequstsPageState extends State<PartyJoinRequstsPage> {
  late List<PartyRequest> requests;
  @override
  void initState() {
    super.initState();
    requests = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final reqs = await PartyCreatorController.partyJoinRequests(widget.party);
      setState(() => requests = reqs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theming.bgColor,
                surfaceTintColor: Theming.bgColor,
                shadowColor: Theming.bgColor,
                pinned: true,
                title: Text(
                  widget.party.name,
                  style: const TextStyle(
                    color: Theming.whiteTone,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                centerTitle: true,
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
              ),
              for (final pr in requests)
                SliverToBoxAdapter(
                  child: _notifItem(pr, context),
                )
            ],
          ),
          Visibility(
            visible: requests.isEmpty,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.emptyHere,
                style: TextStyle(
                  color: Theming.whiteTone.withOpacity(0.7),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notifItem(PartyRequest inv, BuildContext ctx) {
    final timeOfCreation =
        "${inv.createdAt!.year}-${inv.createdAt!.month}-${inv.createdAt!.day} ${inv.createdAt!.hour}:${inv.createdAt!.minute}:${inv.createdAt!.second}";

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: ctx,
          backgroundColor: Theming.bgColor,
          isScrollControlled: true,
          builder: (_) => NotificationSheet(
            inv,
            false,
            (obj) {},
          ),
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
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theming.bgColorLight,
                  backgroundImage: NetworkImage(inv.sender!.pfp!),
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
                        text: AppLocalizations.of(ctx)!.notificationFrom,
                        style: const TextStyle(
                          color: Theming.whiteTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: " @${inv.sender!.username}",
                        style: const TextStyle(
                          color: Theming.greenTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  timeOfCreation,
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
