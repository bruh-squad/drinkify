import 'package:drinkify/controllers/user_controller.dart';
import 'package:flutter/material.dart';

import '../utils/theming.dart';
import '../models/user.dart';
import '../widgets/profilepage/user_info.dart';

class ProfilePage extends StatefulWidget {
  final User? user;
  const ProfilePage(
    this.user, {
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = User.emptyUser();
    if (widget.user != null) return;
    late final User myProfile;
    UserController.me().then((val) {
      myProfile = val;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() => user = myProfile);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      appBar: AppBar(
        backgroundColor: Theming.bgColor,
        title: Text(
          "${user.firstName} ${user.lastName}",
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
            child: UserInfo(user),
          ),
        ),
      ),
    );
  }
}
