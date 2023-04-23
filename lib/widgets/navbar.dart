import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/locale_support.dart';
import '../widgets/glass_morphism.dart';
import '../utils/theming.dart';

class NavBar extends StatefulWidget {
  final double bottomMargin;
  const NavBar({
    required this.bottomMargin,
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int selectedIndex;
  late Size navBarSize;

  @override
  void initState() {
    super.initState();
    selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);

    navBarSize = Size(
      MediaQuery.of(context).size.width - 30 * 2,
      70,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GlassMorphism(
          blur: 30,
          opacity: 0.1,
          borderRadius: BorderRadius.circular(35),
          child: Container(
            height: navBarSize.height,
            width: navBarSize.width,
            padding: const EdgeInsets.all(7),
            child: Stack(
              children: [
                AnimatedContainer(
                  width: navBarSize.width / 3 - 14,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linearToEaseOut,
                  margin: EdgeInsets.only(
                    left: selectedIndex * (navBarSize.width / 3),
                  ),
                  decoration: BoxDecoration(
                    color: Theming.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _navItem(
                      0,
                      context,
                      caption: transl.navbarParties,
                      route: "/parties",
                    ),
                    const SizedBox(width: 14),
                    _navItem(
                      1,
                      context,
                      caption: transl.navbarHome,
                      route: "/",
                    ),
                    const SizedBox(width: 14),
                    _navItem(
                      2,
                      context,
                      caption: transl.navbarProfile,
                      route: "/profile",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: widget.bottomMargin),
      ],
    );
  }

  Widget _navItem(
    int index,
    BuildContext ctx, {
    required String caption,
    required String route,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() => selectedIndex = index);
        ctx.go(route);
      },
      child: Container(
        height: navBarSize.height,
        width: navBarSize.width / 3 - 14,
        alignment: Alignment.center,
        child: AnimatedOpacity(
          curve: Curves.linearToEaseOut,
          opacity: isSelected ? 1.0 : 0.7,
          duration: const Duration(milliseconds: 200),
          child: Text(
            caption,
            style: Styles.navBarText,
          ),
        ),
      ),
    );
  }
}
