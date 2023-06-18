import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/widgets/glass_morphism.dart';
import '/models/user.dart';

class InviteFriendsPage extends StatefulWidget {
  final Function(List<User>) onFinish;
  const InviteFriendsPage({
    required this.onFinish,
    super.key,
  });

  @override
  State<InviteFriendsPage> createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  late List<User> invitedUsers;

  late final TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();
    searchCtrl = TextEditingController();
    invitedUsers = [];
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
            ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top + 20,
                ),
                for (int i = 0; i < 20; i++)
                  _friendPlaceholder(
                    User(
                      dateOfBirth: DateTime.now(),
                      password: "",
                    ),
                  ),
              ],
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

  ///TODO use [user]'s parameters in widgets below
  Widget _friendPlaceholder(User user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  "https://avatars.githubusercontent.com/u/63369072?v=4",
                ),
              ),
            ),
          ),
          const Text("Test user"),
          const Spacer(),
          GestureDetector(
            onTap: () => invitedUsers.add(user),
            child: AnimatedContainer(
              curve: Curves.linearToEaseOut,
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Theming.primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                AppLocalizations.of(context)!.invite,
                style: const TextStyle(
                  color: Theming.whiteTone,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
