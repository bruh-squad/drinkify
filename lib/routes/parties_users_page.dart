import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/partiespage/search_and_map.dart';
import '../widgets/partiespage/party_holder.dart';
import '../widgets/partiespage/user_holder.dart';
import '../widgets/dialogs/success_sheet.dart';
import '../models/party.dart';
import '../models/friend.dart';
import '../models/friend_invitiation.dart';
import '../controllers/user_controller.dart';
import '../utils/theming.dart';
import '../models/search_type.dart';

class PartiesUsersPage extends StatefulWidget {
  const PartiesUsersPage({super.key});

  @override
  State<PartiesUsersPage> createState() => _PartiesUsersPageState();
}

class _PartiesUsersPageState extends State<PartiesUsersPage> {
  late String userId;

  late List<Party> parties;
  late List<Friend> users;
  late SearchType searchType;
  @override
  void initState() {
    super.initState();
    parties = [];
    users = [];
    searchType = SearchType.nearbyParties;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const storage = FlutterSecureStorage();
      final id = await storage.read(key: "user_publicId");
      userId = id!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 20,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: searchType == SearchType.nearbyParties
                  ? _resultList<Party>(parties)
                  : _resultList<Friend>(users),
            ),
            SearchAndMap(
              onTypeChange: (t) {
                setState(() => searchType = t);
              },
              onPartySearch: (p) {
                if (!mounted) return;
                setState(() => parties = p);
              },
              onUserSearch: (u) {
                if (!mounted) return;
                setState(() => users = u);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultList<T>(List<T> iter) {
    return iter.isEmpty
        ? Center(
            child: Text(
              AppLocalizations.of(context)!.emptyHere,
              style: TextStyle(
                color: Theming.whiteTone.withOpacity(0.7),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 130),
                for (final i in iter)
                  T == Party
                      ? PartyHolder(i as Party)
                      : UserHolder(
                          i as Friend,
                          onButtonTap: () async {
                            final success =
                                await UserController.sendFriendInvitation(
                              FriendInvitation(
                                receiverPublicId: i.publicId!,
                                senderPublicId: userId,
                              ),
                            );

                            if (success && mounted) {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Theming.bgColor,
                                isScrollControlled: true,
                                builder: (ctx) => SuccessSheet(
                                  success: true,
                                  successMsg: AppLocalizations.of(ctx)!
                                      .successFriendInvite,
                                  failureMsg: AppLocalizations.of(ctx)!
                                      .failureFriendInvite,
                                ),
                              );
                            } else {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Theming.bgColor,
                                isScrollControlled: true,
                                builder: (ctx) => SuccessSheet(
                                  success: false,
                                  successMsg: AppLocalizations.of(ctx)!
                                      .successFriendInvite,
                                  failureMsg: AppLocalizations.of(ctx)!
                                      .failureFriendInvite,
                                ),
                              );
                            }
                          },
                          buttonChild: const Icon(
                            Icons.person_add_alt_1_rounded,
                            color: Theming.whiteTone,
                          ),
                        ),
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.bottom + 120,
                ),
              ],
            ),
          );
  }
}
