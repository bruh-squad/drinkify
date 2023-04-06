import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/widgets/glass_morphism.dart';
import '/models/user.dart';
import '/utils/theming.dart';
import '/utils/locale_support.dart';

late AppLocalizations transl;

class InviteFriendsPage extends StatelessWidget {
  //list of invited users, index
  final Function(List<User>, int) onCreate;

  //index
  final Function(int) onPrevious;

  const InviteFriendsPage({
    required this.onPrevious,
    required this.onCreate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    transl = LocaleSupport.appTranslates(context);

    const double topLeftRightPadding = 25;

    return Stack(
      children: [
        Dialog(
          backgroundColor: Theming.bgColor,
          insetPadding: const EdgeInsets.only(
            left: topLeftRightPadding,
            right: topLeftRightPadding,
            top: topLeftRightPadding,
            bottom: 130,
          ),
          insetAnimationDuration: const Duration(days: 360),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
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
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
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
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 40,
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
                  //TODO make this working
                  onTap: () => onCreate(
                    [],
                    3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
        height: 70,
        width: (MediaQuery.of(ctx).size.width - padding * 2) / 2 - 10,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: text,
      ),
    );
  }
}
