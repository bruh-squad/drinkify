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
        const SizedBox(height: 35),
        Text(
          AppLocalizations.of(context)!.parties,
          style: const TextStyle(
            color: Theming.whiteTone,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        //Display if there are no parties
        parties.isNotEmpty
            // FIXME fix scrolling
            ? ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 0,
                  ),
                  for (final p in parties)
                    "${date.year}-${date.month}-${date.day}" ==
                            "${p.startTime.year}-${p.startTime.month}-${p.startTime.day}"
                        ? PartyHolder(
                            p,
                            () => context.push("/party", extra: p),
                          )
                        : const SizedBox.shrink(),
                  const SizedBox(
                    width: double.infinity,
                    height: 100,
                  ),
                ],
              )
            : AspectRatio(
                aspectRatio: 1 / 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom:
                          70, // NavBar height to make the Text look more centered
                    ),
                    child: SizedBox(
                      child: Text(
                        AppLocalizations.of(context)!.noParties,
                        style: TextStyle(
                          color: Theming.whiteTone.withOpacity(0.7),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
