import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

class CategoryRow extends StatelessWidget {
  final TabController ctrl;
  const CategoryRow(
    this.ctrl, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: TabBar(
          isScrollable: true,
          controller: ctrl,
          indicatorColor: Theming.primaryColor,
          dividerColor: Theming.bgColor,
          splashFactory: NoSplash.splashFactory,
          tabs: [
            _category(0, AppLocalizations.of(context)!.friendInvitations),
            _category(1, AppLocalizations.of(context)!.partyInvitations),
            _category(2, AppLocalizations.of(context)!.sentJoinRequests),
          ],
        ),
      ),
    );
  }

  Widget _category(int index, String caption) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(15),
      child: Text(
        caption,
        style: TextStyle(
          color: Theming.whiteTone.withOpacity(0.7),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
