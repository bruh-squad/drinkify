import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/theming.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
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
