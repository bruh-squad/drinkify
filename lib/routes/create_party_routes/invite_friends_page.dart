import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/utils/locale_support.dart';
import '/widgets/glass_morphism.dart';

class InviteFriendsPage extends StatefulWidget {
  const InviteFriendsPage({super.key});

  @override
  State<InviteFriendsPage> createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  late AppLocalizations transl;

  late final TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();
    searchCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    transl = LocaleSupport.appTranslates(context);

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
                      onPressed: () => Navigator.pop(context),
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
                          hintText: transl.searchAFriend,
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
