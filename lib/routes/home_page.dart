import 'package:flutter/material.dart';

import '../utils/theming.dart';
import '../widgets/homepage/welcome_header.dart';
import '../widgets/homepage/date_row.dart';
import '../widgets/homepage/party_list.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;
  @override
  void initState() {
    super.initState();
    user = User.emptyUser();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userData = await UserController.me();
      setState(() => user = userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 20,
        ),
        child: Column(
          children: [
            //Had to use many paddings to make the DateRow boxes look better
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: WelcomeHeader(user),
            ),
            DateRow(
              user,
              textPadding: const EdgeInsets.symmetric(horizontal: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: PartyList(user),
            ),
          ],
        ),
      ),
    );
  }
}
