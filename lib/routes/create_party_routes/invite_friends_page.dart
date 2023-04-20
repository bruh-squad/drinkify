import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/widgets/glass_morphism.dart';
import '/models/user.dart';
import '/utils/theming.dart';
import '/utils/locale_support.dart';

late AppLocalizations transl;

List<User> invitedUsers = [];

class InviteFriendsPage extends StatelessWidget {
  /// * list of invited users, index
  final Function(List<User>, int) onCreate;

  /// * previous page index
  final Function(int) onPrevious;

  const InviteFriendsPage({
    required this.onPrevious,
    required this.onCreate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    transl = LocaleSupport.appTranslates(context);

    const double topLeftRightPadding = 15;

    return Scaffold(
      backgroundColor: Theming.bgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          transl.createAParty,
          style: const TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theming.bgColor,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      for (int i = 0; i < 20; i++)
                        _friendPlaceholder(
                          i,
                          user: User(
                            password: "asdasd",
                            dateOfBirth: DateTime.now(),
                          ),
                        ),
                      const SizedBox(height: 160),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassMorphism(
                        blur: 30,
                        opacity: 0.1,
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: TextField(
                            cursorColor: Theming.primaryColor,
                            style: const TextStyle(
                              color: Theming.whiteTone,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: transl.searchAFriend,
                              hintStyle: TextStyle(
                                color: Theming.whiteTone.withOpacity(0.5),
                              ),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: Theming.primaryColor,
                                size: 34,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 140,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Theming.bgColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Theming.bgColor,
                    offset: Offset(0, -40),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 80,
                  left: 30,
                  right: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _navButton(
                      context,
                      topLeftRightPadding,
                      backgroundColor: Theming.whiteTone,
                      text: Text(
                        transl.back,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      onTap: () => onPrevious(2),
                    ),
                    _navButton(
                      context,
                      topLeftRightPadding,
                      backgroundColor: Theming.primaryColor,
                      text: Text(
                        transl.create,
                        style: const TextStyle(
                          color: Theming.whiteTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      onTap: () => onCreate(
                        [],
                        4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _friendPlaceholder(
    int index, {
    required User user,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Theming.bgColorLight,
            backgroundImage: NetworkImage(
              "https://imgs.search.brave.com/31oYFXxCmIWDe8I19SpbJ9XZTlv0EO2Bodo7GsdtUqg/rs:fit:748:784:1/g:ce/aHR0cHM6Ly80LmJw/LmJsb2dzcG90LmNv/bS8tRk5MSXBOQzkz/SWcvVkNnR2ptd2hX/V0kvQUFBQUFBQUFF/RWcvUV9zeGp0MzFM/aDAvczE2MDAvQ3V0/ZSUyQmJhYnklMkIl/MkIoNSkuanBn",
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "Test User",
            style: TextStyle(color: Theming.whiteTone),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Theming.primaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                transl.invite,
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

  Widget _navButton(
    BuildContext ctx,
    double padding, {
    required Color backgroundColor,
    required Text text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: (MediaQuery.of(ctx).size.width - padding * 2) / 2 - 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: text,
      ),
    );
  }
}
