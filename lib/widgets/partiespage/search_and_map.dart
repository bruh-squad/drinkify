import 'package:flutter/material.dart' hide SearchController;
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/models/friend.dart';
import '/controllers/search_controller.dart';
import '/models/party.dart';
import '/utils/ext.dart';
import '/models/search_type.dart';
import '/widgets/glass_morphism.dart';

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

class _SearchAndMapState extends State<SearchAndMap> with LocationUtils {
  late int selectedIndex;
  late final TextEditingController searchCtrl;
  late SearchType searchType;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    searchCtrl = TextEditingController();
    searchType = SearchType.nearbyParties;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final location = await userLocation();
      if (location == null) return;
      final parties = await SearchController.seachPartiesByDistance(
        location: location,
      );
      widget.onPartySearch(parties);
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchCtrl.dispose();
  }

  String _getSearchBarText(BuildContext ctx, SearchType type) {
    switch (type) {
      case SearchType.nearbyParties:
        return AppLocalizations.of(context)!.howFar;
      case SearchType.users:
        return AppLocalizations.of(context)!.searchAFriend;
    }
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
                //Create party button
                GestureDetector(
                  onTap: () => context.push("/create-party"),
                  child: Container(
                    height: 50,
                    width: 50,
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
                        size: 30,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                //Search bar
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 180,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theming.whiteTone,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    cursorColor: Theming.primaryColor,
                    textAlign: TextAlign.center,
                    controller: searchCtrl,
                    keyboardType: searchType == SearchType.nearbyParties
                        ? TextInputType.number
                        : TextInputType.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theming.bgColor,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 45,
                        minHeight: 0,
                      ),
                      hintText: _getSearchBarText(context, searchType),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theming.bgColor.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Spacer(),

                //Seach button
                GestureDetector(
                  onTap: () async {
                    switch (searchType) {
                      case SearchType.nearbyParties:
                        if (searchCtrl.text.isEmpty) return;
                        final coords = await userLocation();
                        if (coords == null) return;
                        final p = await SearchController.seachPartiesByDistance(
                          location: coords,
                          meters: double.parse(searchCtrl.text),
                        );
                        widget.onPartySearch(p);
                        return;
                      case SearchType.users:
                        if (searchCtrl.text.isEmpty) return;
                        final u = await SearchController.searchUser(
                          searchCtrl.text,
                        );
                        widget.onUserSearch(u);
                        return;
                    }
                  },
                  child: GlassMorphism(
                    blur: 0,
                    opacity: 0.1,
                    borderRadius: BorderRadius.circular(10),
                    child: const SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.search_rounded,
                        color: Theming.primaryColor,
                        size: 30,
                      ),
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
                  type: SearchType.nearbyParties,
                  caption: AppLocalizations.of(context)!.inYourArea,
                ),
                _categoryItem(
                  1,
                  type: SearchType.users,
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
    required SearchType type,
    required String caption,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        searchCtrl.text = "";
        setState(() {
          selectedIndex = index;
          searchType = type;
        });
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
