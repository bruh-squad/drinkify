import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/theming.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      appBar: AppBar(
        backgroundColor: Theming.bgColor,
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
        title: Text(
          AppLocalizations.of(context)!.friends,
          style: const TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theming.bgColor,
              expandedHeight: 200,
              pinned: true,
              surfaceTintColor: Colors.transparent,
              leading: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            for (int i = 0; i < 15; i++) _friendPlaceholder(),
          ],
        ),
      ),
    );
  }

  Widget _friendPlaceholder() {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
      ),
    );
  }
}
