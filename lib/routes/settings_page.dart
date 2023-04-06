import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/settings_routes/log_out_page.dart';

import '../widgets/glass_morphism.dart';

import '../utils/theming.dart';
import '../utils/locale_support.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);
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
              Text(
                transl.settings,
                style: const TextStyle(
                  color: Theming.whiteTone,
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                ),
              ),
              _settingsItem(
                caption: transl.editProfile,
                onTap: () => context.push("/edit-profile"),
              ),
              _settingsItem(
                caption: transl.organization,
                onTap: () => context.push("/organization"),
              ),
              _settingsItem(
                caption: transl.language,
                onTap: () => context.push("/languages"),
              ),
              _settingsItem(
                caption: transl.privacy,
                onTap: () => context.push("/privacy"),
              ),
              _settingsItem(
                caption: transl.logOut,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Theming.bgColor,
                    enableDrag: false,
                    builder: (ctx) => const LogoutPage(),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsItem({
    required String caption,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GestureDetector(
        onTap: onTap,
        child: GlassMorphism(
          blur: 20,
          opacity: 0.15,
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 16 / 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    caption,
                    style: const TextStyle(
                      color: Theming.whiteTone,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theming.whiteTone,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
