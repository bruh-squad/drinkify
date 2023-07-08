import 'package:drinkify/controllers/user_controller.dart';
import 'package:drinkify/models/user.dart';
import 'package:flutter/material.dart' hide SearchController;

import '../utils/theming.dart';
import '../widgets/profilepage/user_info.dart';
import '../models/friend.dart';
import 'package:drinkify/controllers/search_controller.dart';

class ProfilePage extends StatefulWidget {
  final Friend? user;
  const ProfilePage(
    this.user, {
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? user;
  late Friend? friend;

  @override
  void initState() {
    super.initState();
    user = User.emptyUser();
    friend = const Friend();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_isMyProfile) {
        final myProfileData = await UserController.me();
        if (!mounted) return;
        setState(() => user = myProfileData);
        return;
      }

      final data = await SearchController.searchUserByPublicId(
        widget.user!.publicId!,
      );
      if (!mounted) return;
      setState(() => friend = data);
    });
  }

  bool get _isMyProfile => widget.user == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      appBar: AppBar(
        backgroundColor: Theming.bgColor,
        title: Text(
          _isMyProfile
              ? "${user!.firstName} ${user!.lastName}"
              : "${friend!.firstName} ${friend!.lastName}",
          style: const TextStyle(
            color: Theming.whiteTone,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 20,
            ),
            child: UserInfo(user, friend),
          ),
        ),
      ),
    );
  }
}
