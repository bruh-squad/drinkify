import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/widgets/glass_morphism.dart';
import '/controllers/user_controller.dart';
import '/models/friend.dart';
import '/widgets/partiespage/user_holder.dart';

class InviteFriendsPage extends StatefulWidget {
  final Function(List<Friend>) onFinish;
  const InviteFriendsPage({
    required this.onFinish,
    super.key,
  });

  @override
  State<InviteFriendsPage> createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  late List<Friend> friends;
  late List<Friend> invitedUsers;

  late final TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();
    searchCtrl = TextEditingController();
    invitedUsers = [];
    friends = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await UserController.me();
      setState(() => friends = user.friends!);
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theming.bgColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 10,
          left: 30,
          right: 30,
        ),
        child: Stack(
          children: [
            friends.isNotEmpty
                ? ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top + 20,
                      ),
                      for (final user in friends)
                        UserHolder(
                          user,
                          onButtonTap: () => invitedUsers.add(user),
                          buttonChild: Text(
                            AppLocalizations.of(context)!.invite,
                            style: const TextStyle(
                              color: Theming.whiteTone,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  )
                : Center(
                    child: Text(
                      AppLocalizations.of(context)!.emptyHere,
                      style: TextStyle(
                        color: Theming.whiteTone.withOpacity(0.7),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            GlassMorphism(
              borderRadius: BorderRadius.circular(30),
              blur: 20,
              opacity: 0.1,
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.onFinish(invitedUsers);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 110,
                      decoration: BoxDecoration(
                        color: Theming.whiteTone,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: searchCtrl,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(right: 15),
                          hintText: AppLocalizations.of(context)!.searchAFriend,
                          icon: const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.search_rounded,
                              size: 30,
                              color: Theming.primaryColor,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Theming.bgColor.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
