import 'package:flutter/material.dart';

import '/routes/create_party_page.dart';
import '/utils/theming.dart';
import '/utils/locale_support.dart';

class SearchAndMap extends StatefulWidget {
  const SearchAndMap({super.key});

  @override
  State<SearchAndMap> createState() => _SearchAndMapState();
}

class _SearchAndMapState extends State<SearchAndMap> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);
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
                  onTap: () {
                    showDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      useRootNavigator: true,
                      useSafeArea: true,
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return const CreatePartyPage();
                      },
                    );
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Theming.whiteTone.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      size: 32,
                      color: Theming.primaryColor,
                    ),
                  ),
                ),

                const Spacer(),

                //Search bar
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 55 - 60 - 20,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theming.whiteTone,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    cursorColor: Theming.primaryColor,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theming.bgColor,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: transl.lookingForAParty,
                      hintStyle: Styles.hintTextSearchBar,
                      border: InputBorder.none,
                      icon: const Icon(
                        Icons.search,
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
                _categoryItem(0, caption: transl.parties),
                _categoryItem(1, caption: transl.friends),
                _categoryItem(2, caption: transl.inYourArea),
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
          color: isSelected ? Theming.primaryColor.withOpacity(0.7) : Theming.whiteTone.withOpacity(0.1),
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
