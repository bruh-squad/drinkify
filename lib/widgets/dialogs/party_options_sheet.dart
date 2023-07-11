import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/models/party.dart';
import '/controllers/party_creator_controller.dart';
import '/widgets/dialogs/success_sheet.dart';

class PartyOptionsSheet extends StatelessWidget {
  final Party party;
  const PartyOptionsSheet(
    this.party, {
    super.key,
  });

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
              () {},
            ),
            _option(
              Icons.delete_rounded,
              AppLocalizations.of(context)!.deleteParty,
              () {
                PartyCreatorController.deleteParty(
                  party.publicId!,
                ).then((deleted) {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Theming.bgColor,
                    builder: (ctx) => SuccessSheet(
                      success: deleted,
                      successMsg: AppLocalizations.of(context)!.deleteSuccess,
                      failureMsg: AppLocalizations.of(context)!.deleteFailure,
                    ),
                  );
                });
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
