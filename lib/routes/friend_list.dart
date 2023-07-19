import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/partiespage/user_holder.dart';
import '../utils/theming.dart';
import '../models/friend.dart';
import '../controllers/user_controller.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  late List<Friend> friends;

  @override
  void initState() {
    super.initState();
    friends = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await UserController.me();
      if (!mounted) return;
      setState(() => friends = user.friends!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theming.bgColor,
                pinned: true,
                surfaceTintColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.friends,
                  style: const TextStyle(
                    color: Theming.whiteTone,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
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
              ),
              friends.isEmpty ? const SliverToBoxAdapter() : _friendList(),
            ],
          ),
          Visibility(
            visible: friends.isEmpty,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.emptyHere,
                style: TextStyle(
                  color: Theming.whiteTone.withOpacity(0.7),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _friendList() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            for (final f in friends)
              UserHolder(
                f,
                onButtonTap: () => context.go("/profile", extra: f),
                buttonChild: Text(
                  AppLocalizations.of(context)!.navbarProfile,
                  style: const TextStyle(
                    color: Theming.whiteTone,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
