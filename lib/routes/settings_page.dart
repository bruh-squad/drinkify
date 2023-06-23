import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../routes/settings_routes/log_out_page.dart';
import '../widgets/glass_morphism.dart';
import '../utils/theming.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: MediaQuery.of(context).padding.top + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(right: 15),
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theming.whiteTone,
                      size: 26,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.settings,
                    style: const TextStyle(
                      color: Theming.whiteTone,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  _settingsItem(
                    caption: AppLocalizations.of(context)!.editProfile,
                    prefixIcon: Icons.mode_edit_rounded,
                    onTap: () => context.push("/edit-profile"),
                  ),
                  _settingsItem(
                    caption: AppLocalizations.of(context)!.organization,
                    prefixIcon: Icons.people_rounded,
                    onTap: () => context.push("/organization"),
                  ),
                ],
              ),
              _settingsItem(
                caption: AppLocalizations.of(context)!.logOut,
                prefixIcon: Icons.logout_rounded,
                isLogoutButton: true,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Theming.bgColor,
                    isScrollControlled: true,
                    builder: (_) => const LogoutPage(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsItem({
    required String caption,
    required VoidCallback onTap,
    required IconData prefixIcon,
    bool isLogoutButton = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: onTap,
        child: GlassMorphism(
          blur: 0,
          opacity: 0.1,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theming.primaryColor.withOpacity(0.2),
                  ),
                  child: Icon(
                    prefixIcon,
                    color: Theming.primaryColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  caption,
                  style: const TextStyle(
                    color: Theming.whiteTone,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: !isLogoutButton,
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theming.whiteTone,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
