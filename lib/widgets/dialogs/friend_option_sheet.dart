import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '/utils/theming.dart';
import '/widgets/dialogs/success_sheet.dart';
import '/controllers/user_controller.dart';
import '/models/friend.dart';

class FriendOptionSheet extends StatefulWidget {
  final Friend friend;
  const FriendOptionSheet(
    this.friend, {
    super.key,
  });

  @override
  State<FriendOptionSheet> createState() => _FriendOptionSheetState();
}

class _FriendOptionSheetState extends State<FriendOptionSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Wrap(
          children: [
            _option(
              Icons.person_rounded,
              AppLocalizations.of(context)!.showProfile,
              () => context.push("/profile", extra: widget.friend),
            ),
            _option(
              Icons.delete_rounded,
              AppLocalizations.of(context)!.removeFriend,
              () async {
                final isRemoved = await UserController.removeFriend(
                  widget.friend,
                );
                if (!mounted) return;
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Theming.bgColor,
                  builder: (ctx) => SuccessSheet(
                    success: isRemoved,
                    successMsg: AppLocalizations.of(ctx)!.removeFriendSuccess,
                    failureMsg: AppLocalizations.of(ctx)!.removeFriendFailure,
                  ),
                );
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
