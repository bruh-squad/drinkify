import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/models/friend.dart';
import '/widgets/glass_morphism.dart';

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

  // FIXME routing doesnt work
  void _goToProfile(BuildContext ctx) => ctx.push("/profile", extra: user);

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
            child: Text(
              "${user.firstName} ${user.lastName}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onButtonTap,
            child: GlassMorphism(
              blur: 0,
              opacity: 0.1,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buttonChild,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
