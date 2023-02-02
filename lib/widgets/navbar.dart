import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/theming.dart';

class NavBar extends StatefulWidget {
  final double bottomMargin;
  const NavBar({required this.bottomMargin, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int selectedIndex;
  late Size navBarSize;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    navBarSize = Size(
      MediaQuery.of(context).size.width - 30 * 2,
      70,
    );

    return Container(
      height: navBarSize.height,
      width: navBarSize.width,
      margin: EdgeInsets.only(bottom: widget.bottomMargin),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Theming.primaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
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
              color: Theming.bgColor,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navItem(
                0,
                context,
                caption: "Home",
                route: "/",
              ),
              const SizedBox(width: 14),
              _navItem(
                1,
                context,
                caption: "Parties",
                route: "/parties",
              ),
              const SizedBox(width: 14),
              _navItem(
                2,
                context,
                caption: "Profile",
                route: "/profile",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    int index,
    BuildContext ctx, {
    required String caption,
    required String route,
  }) {
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
          opacity: selectedIndex == index ? 1.0 : 0.8,
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
