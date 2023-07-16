import 'package:flutter/material.dart';

import '../utils/theming.dart';
import '../widgets/homepage/welcome_header.dart';
import '../widgets/homepage/date_row.dart';
import '../widgets/homepage/party_list.dart';
import '../controllers/user_controller.dart';
import '../controllers/party_controller.dart';
import '../models/user.dart';
import '../models/party.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;
  List<Party> parties = [];
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    user = User.emptyUser();
    selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userData = await UserController.me();
      final partyData = await PartyController.myParties();
      if (!mounted) return;
      setState(() {
        user = userData;
        parties = partyData;
      });
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Had to use many paddings to make the DateRow boxes look better
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: WelcomeHeader(user),
              ),
              DateRow(
                user,
                (dt) => setState(() => selectedDate = dt),
                textPadding: const EdgeInsets.symmetric(horizontal: 30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: PartyList(selectedDate, parties),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
