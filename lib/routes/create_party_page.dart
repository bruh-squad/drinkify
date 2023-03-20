// ignore_for_file: unused_element

import 'package:drinkify/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '/utils/theming.dart';

class CreatePartyPage extends StatefulWidget {
  const CreatePartyPage({super.key});

  @override
  State<CreatePartyPage> createState() => _CreatePartyPageState();
}

class _CreatePartyPageState extends State<CreatePartyPage> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  Widget get _subPage {
    switch (selectedIndex) {
      case 0:
        return _dateAndTimePage();
      case 1:
        return _peopleCountPage();
      default:
        return _partyPivacyPage();
    }
  }

  String get _subPageTitle {
    switch (selectedIndex) {
      case 0:
        return "Data i godzina";
      case 1:
        return "Liczba osób";
      default:
        return "Status imprezy";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theming.bgColor,
      insetPadding: const EdgeInsets.all(25),
      insetAnimationDuration: const Duration(days: 360),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Stwórz imprezę",
                  style: TextStyle(
                    color: Theming.whiteTone,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              //Title
              _categoryText("Tytuł"),
              Container(
                width: double.infinity,
                height: 60,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Theming.whiteTone.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  style: const TextStyle(
                    color: Theming.whiteTone,
                  ),
                  decoration: InputDecoration(
                    hintText: "Dodaj tytuł imprezy",
                    hintStyle: TextStyle(
                      color: Theming.whiteTone.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              _pageSwitcher(),

              const SizedBox(height: 10),
              SizedBox(
                height: 240,
                width: double.infinity,
                child: _subPage,
              ),
              const SizedBox(height: 20),
              _categoryText("Lokalizacja"),
              SizedBox(
                width: double.infinity,
                height: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(0, 80),
                      zoom: 0,
                      interactiveFlags:
                          InteractiveFlag.all - InteractiveFlag.all,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () => context.push("/choose-location"),
                        child: TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: "app.drinkify",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  "Dalej",
                  style: TextStyle(
                    color: Theming.whiteTone,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryText(String caption) {
    return Text(
      caption,
      style: const TextStyle(
        color: Theming.whiteTone,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget _pageSwitcher() {
    const int maxPages = 3;
    return Row(
      children: [
        _categoryText(_subPageTitle),
        const Spacer(),
        GestureDetector(
          onTap: () {
            if (selectedIndex <= 0) return;
            setState(() {
              selectedIndex--;
            });
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color:
                selectedIndex != 0 ? Theming.primaryColor : Colors.transparent,
          ),
        ),
        Text(
          "${selectedIndex + 1} / $maxPages",
          style: TextStyle(
            color: Theming.whiteTone.withOpacity(0.5),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (selectedIndex >= maxPages - 1) return;
            setState(() {
              selectedIndex++;
            });
          },
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: selectedIndex != maxPages - 1
                ? Theming.primaryColor
                : Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _friendPlaceholder(
    int index, {
    required User user,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Theming.bgColorLight,
            backgroundImage: NetworkImage(
              "https://imgs.search.brave.com/31oYFXxCmIWDe8I19SpbJ9XZTlv0EO2Bodo7GsdtUqg/rs:fit:748:784:1/g:ce/aHR0cHM6Ly80LmJw/LmJsb2dzcG90LmNv/bS8tRk5MSXBOQzkz/SWcvVkNnR2ptd2hX/V0kvQUFBQUFBQUFF/RWcvUV9zeGp0MzFM/aDAvczE2MDAvQ3V0/ZSUyQmJhYnklMkIl/MkIoNSkuanBn",
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "Test User",
            style: TextStyle(color: Theming.whiteTone),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Theming.primaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Text(
                "Zaproś",
                style: TextStyle(
                  color: Theming.whiteTone,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inviteFriendsPage() {
    return ListView(
      children: [
        for (int i = 0; i < 7; i++)
          _friendPlaceholder(
            i,
            user: User(
              dateOfBirth: DateTime.now(),
              password: "",
            ),
          ),
      ],
    );
  }

  Widget _dateAndTimePage() {
    return const SizedBox();
  }

  Widget _peopleCountPage() {
    return const SizedBox();
  }

  Widget _partyPivacyPage() {
    return const SizedBox();
  }
}
