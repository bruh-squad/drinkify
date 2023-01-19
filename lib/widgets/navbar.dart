import 'package:alkoholicy/utils/theming.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int selectedIndex;
  late Alignment bgAlignment;

  Widget _navItem(
    int index,
    BuildContext ctx, {
    required Size navSize,
    required String caption,
    required String route,
  }) {
    return GestureDetector(
      ///If items behind [NavBar] also receive events then change to [HitTestBehavior.opaque]
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        ctx.push(route);
      },
      child: SizedBox(
        height: navSize.height,
        width: navSize.width / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              caption,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: selectedIndex == index
                    ? Colors.white
                    : Colors.grey.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 40),
      width: 340,
      height: 66,
      decoration: BoxDecoration(color: Theming.primaryColor, borderRadius: BorderRadius.circular(100)),
      child: Stack(children: [
        Align(
          alignment: bgAlignment,
          child: AnimatedContainer(
            margin: EdgeInsets.all(),
            width: 300/3,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Theming.bgColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ]),
    );
  }
}
