import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '/utils/theming.dart';
import '/models/party.dart';
import '/controllers/party_creator_controller.dart';
import '/widgets/dialogs/success_sheet.dart';

class PartyOptionsSheet extends StatefulWidget {
  final Party party;
  final VoidCallback onDelete;
  const PartyOptionsSheet(
    this.party,
    this.onDelete, {
    super.key,
  });

  @override
  State<PartyOptionsSheet> createState() => _PartyOptionsSheetState();
}

class _PartyOptionsSheetState extends State<PartyOptionsSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Wrap(
          children: [
            _option(
              Icons.edit_rounded,
              AppLocalizations.of(context)!.editParty,
              () => context.push("/edit-party", extra: widget.party),
            ),
            _option(
              Icons.mail_rounded,
              AppLocalizations.of(context)!.partyJoinRequests,
              () => context.push("/party-join-requests", extra: widget.party),
            ),
            _option(
              Icons.people_rounded,
              AppLocalizations.of(context)!.partyParticipants,
              () => context.push("/party-participants", extra: widget.party),
            ),
            _option(
              Icons.delete_rounded,
              AppLocalizations.of(context)!.deleteParty,
              () async {
                final isDeleted = await PartyCreatorController.deleteParty(
                  widget.party.publicId!,
                );
                if (!mounted) return;
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Theming.bgColor,
                  builder: (ctx) => SuccessSheet(
                    success: isDeleted,
                    successMsg: AppLocalizations.of(ctx)!.deleteSuccess,
                    failureMsg: AppLocalizations.of(ctx)!.deleteFailure,
                  ),
                );
                widget.onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _option(IconData icon, String caption, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theming.primaryColor.withOpacity(0.2),
              ),
              child: Icon(
                icon,
                color: Theming.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              caption,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
