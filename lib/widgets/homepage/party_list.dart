import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '/utils/theming.dart';
import '/models/party.dart';
import '/widgets/partiespage/party_holder.dart';

class PartyList extends StatelessWidget {
  final List<Party> parties;
  final DateTime date;
  const PartyList(
    this.date,
    this.parties, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        _items(context),
      ],
    );
  }

  Widget _items(BuildContext ctx) {
    final partyList = <Widget>[];
    for (final p in parties) {
      if ("${date.year}-${date.month}-${date.day}" ==
          "${p.startTime.year}-${p.startTime.month}-${p.startTime.day}") {
        partyList.add(PartyHolder(
          p,
          () => ctx.push(
            "/party",
            extra: [p, false],
          ),
        ));
      }
    }

    return SizedBox(
      height: MediaQuery.of(ctx).size.height - 374,
      child: Stack(
        children: [
          ListView(
            children: [
              partyList.isEmpty
                  ? AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom:
                                70, // NavBar height to make the Text look more centered
                          ),
                          child: SizedBox(
                            child: Text(
                              AppLocalizations.of(ctx)!.noParties,
                              style: TextStyle(
                                color: Theming.whiteTone.withOpacity(0.7),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              ...partyList,
              const SizedBox(
                width: double.infinity,
                height: 100,
              ),
            ],
          ),
          Container(
            height: 20,
            width: double.infinity,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theming.bgColor,
                  offset: Offset(0, 5),
                  spreadRadius: 25,
                  blurRadius: 15,
                ),
              ],
            ),
          ),
          Text(
            AppLocalizations.of(ctx)!.parties,
            style: const TextStyle(
              color: Theming.whiteTone,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
