import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/models/friend.dart';
import '/utils/theming.dart';

class UserHolder extends StatelessWidget {
  final Friend user;
  final Widget buttonChild;
  final VoidCallback onButtonTap;
  const UserHolder(
    this.user, {
    required this.buttonChild,
    required this.onButtonTap,
    super.key,
  });

  void _goToProfile(BuildContext ctx) => ctx.go("/profile", extra: user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _goToProfile(context),
            child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user.pfp!),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _goToProfile(context),
            child: Text("${user.firstName} ${user.lastName}"),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: AnimatedContainer(
              curve: Curves.linearToEaseOut,
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Theming.primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: buttonChild,
            ),
          ),
        ],
      ),
    );
  }
}
