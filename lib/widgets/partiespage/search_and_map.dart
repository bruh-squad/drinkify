import 'package:flutter/material.dart' hide SearchController;
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/models/friend.dart';
import '/controllers/search_controller.dart';
import '/models/party.dart';

class SearchAndMap extends StatefulWidget {
  final Function(List<Party>) onPartySearch;
  final Function(List<Friend>) onUserSearch;
  const SearchAndMap({
    required this.onPartySearch,
    required this.onUserSearch,
    super.key,
  });

  @override
  State<SearchAndMap> createState() => _SearchAndMapState();
}

class _SearchAndMapState extends State<SearchAndMap> {
  late int selectedIndex;
  late final TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    searchCtrl = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final tempParties = await SearchController.seachPartiesByDistance(1000);
      widget.onPartySearch(tempParties);
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Theming.bgColor,
        boxShadow: [
          BoxShadow(
            color: Theming.bgColor,
            offset: Offset(0, 5),
            spreadRadius: 15,
            blurRadius: 15,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            //Searchbar and add party button
            Row(
              children: [
                //Map button
                GestureDetector(
                  onTap: () => context.push("/create-party"),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Theming.whiteTone.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.deepPurpleAccent,
                            Theming.primaryColor,
                          ],
                        ).createShader(
                          const Rect.fromLTRB(
                            0,
                            0,
                            24,
                            24,
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.nightlife_rounded,
                        size: 32,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                //Search bar
                Container(
                  decoration: const BoxDecoration(
                    color: Theming.primaryColor,
                  ),
                ),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 55 - 60 - 20,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Theming.whiteTone,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: TextField(
                    cursorColor: Theming.primaryColor,
                    textAlign: TextAlign.left,
                    controller: searchCtrl,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theming.bgColor,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.lookingForAParty,
                      hintStyle: Styles.hintTextSearchBar,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            //Category roll
            Row(
              children: [
                _categoryItem(
                  0,
                  caption: AppLocalizations.of(context)!.inYourArea,
                ),
                _categoryItem(
                  1,
                  caption: AppLocalizations.of(context)!.friends,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(
    int index, {
    required String caption,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 125),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? Theming.primaryColor.withOpacity(0.7)
              : Theming.whiteTone.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          caption,
          style: const TextStyle(
            color: Theming.whiteTone,
          ),
        ),
      ),
    );
  }
}
