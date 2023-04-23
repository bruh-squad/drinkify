import 'package:flutter/material.dart';

import '../models/user.dart';

import './create_party_routes/title_page.dart';
import './create_party_routes/description_page.dart';
import './create_party_routes/date_and_time_page.dart';
import './create_party_routes/invite_friends_page.dart';

class CreatePartyPage extends StatefulWidget {
  const CreatePartyPage({super.key});

  @override
  State<CreatePartyPage> createState() => _CreatePartyPageState();
}

class _CreatePartyPageState extends State<CreatePartyPage> {
  int index = 0;
  late final List<Widget> routes;

  var partyTitle = TextEditingController();
  var partyPeopleCount = TextEditingController();
  int partyStatusNumber = 1;
  String partyLocation = ""; //format: POINT(lat lng)
  var partyDescription = TextEditingController();
  DateTime startTime = DateTime.now();
  DateTime stopTime = DateTime.now();
  List<User> partyUsers = [];

  @override
  void initState() {
    super.initState();
    routes = [
      TitlePage(
        onNext: (title, peopleCount, partyStatus, pos, idx) {
          setState(() => index = idx);
          partyTitle = title;
          partyPeopleCount = peopleCount;
          partyStatusNumber = partyStatus;
          partyLocation = pos;
        },
      ),
      DescriptionPage(
        onPrevious: (idx) {
          setState(() => index = idx);
        },
        onNext: (desc, idx) {
          setState(() => index = idx);
          partyDescription = desc;
        },
      ),
      DateAndTimePage(
        onPrevious: (idx) {
          setState(() => index = idx);
        },
        onNext: (start, stop, idx) {
          setState(() => index = idx);
          startTime = start;
          stopTime = stop;
        },
      ),
      InviteFriendsPage(
        onPrevious: (idx) {
          setState(() => index = idx);
        },
        onCreate: (users) {
          partyUsers = users;
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => routes[index];
}
