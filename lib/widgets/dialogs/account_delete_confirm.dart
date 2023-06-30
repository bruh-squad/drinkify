import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/controllers/user_controller.dart';
import 'package:go_router/go_router.dart';

class AccountDeleteConfirm extends StatelessWidget {
  const AccountDeleteConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const SizedBox(
              height: 10,
              width: double.infinity,
            ),
            Text(
              AppLocalizations.of(context)!.sureDeleteAccount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Theming.whiteTone,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 15,
              width: double.infinity,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: MediaQuery.of(context).size.width - 120,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Theming.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  AppLocalizations.of(context)!.doNotDeleteAccount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theming.whiteTone,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            GestureDetector(
              onTap: () async {
                final isDeleted = await UserController.deleteMe();
                if (context.mounted && isDeleted) {
                  context.go("/login");
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 120,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Theming.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  AppLocalizations.of(context)!.deleteAccount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theming.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
