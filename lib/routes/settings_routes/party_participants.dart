import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/party.dart';
import '/utils/theming.dart';
import '/widgets/partiespage/user_holder.dart';

class PartyParticipantsPage extends StatelessWidget {
  final Party party;
  const PartyParticipantsPage(
    this.party, {
    super.key,
  });

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
                  party.name,
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
              for (final p in party.participants!)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: UserHolder(p),
                  ),
                ),
            ],
          ),
          Visibility(
            visible: party.participants!.isEmpty,
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
}
