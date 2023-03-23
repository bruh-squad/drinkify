import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '/utils/theming.dart';

typedef TEC = TextEditingController;

class TitlePage extends StatefulWidget {
  //Ctrl, Ctrl, party status, next page index
  final Function(TEC, TEC, int, int) onNext;
  const TitlePage({
    required this.onNext,
    super.key,
  });

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  int subPageIndex = 0;

  var titleCtrl = TextEditingController();
  var peopleCountCtrl = TextEditingController();
  int partyStatus = 1; //1: private  2: public  3: secret
  Widget get _subPage {
    switch (subPageIndex) {
      case 0:
        return _peopleCountPage();
      default:
        return _partyPivacyPage();
    }
  }

  String get _subPageTitle {
    switch (subPageIndex) {
      case 0:
        return "Liczba osób";
      default:
        return "Status imprezy";
    }
  }

  @override
  Widget build(BuildContext context) {
    const double topLeftRightPadding = 25;

    return Stack(
      children: [
        Dialog(
          backgroundColor: Theming.bgColor,
          insetPadding: const EdgeInsets.only(
            left: topLeftRightPadding,
            right: topLeftRightPadding,
            top: topLeftRightPadding,
            bottom: 130,
          ),
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
              child: SingleChildScrollView(
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
                        controller: titleCtrl,
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
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 40,
            ),
            child: GestureDetector(
              onTap: () {
                widget.onNext(
                  titleCtrl,
                  peopleCountCtrl,
                  partyStatus,
                  1,
                );
              },
              child: Container(
                height: 70,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theming.primaryColor,
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
            ),
          ),
        ),
      ],
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
    const int maxPages = 2;
    return Row(
      children: [
        _categoryText(_subPageTitle),
        const Spacer(),
        GestureDetector(
          onTap: () {
            if (subPageIndex <= 0) return;
            setState(() => subPageIndex--);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color:
                subPageIndex != 0 ? Theming.primaryColor : Colors.transparent,
          ),
        ),
        Text(
          "${subPageIndex + 1} / $maxPages",
          style: TextStyle(
            color: Theming.whiteTone.withOpacity(0.5),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (subPageIndex >= maxPages - 1) return;
            setState(() => subPageIndex++);
          },
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: subPageIndex != maxPages - 1
                ? Theming.primaryColor
                : Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _peopleCountPage() {
    return Center(
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 25 * 2 - 30 * 2 - 60,
        padding: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Theming.whiteTone.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: peopleCountCtrl,
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: true,
          ),
          decoration: InputDecoration(
            hintText: "Liczba osób",
            hintStyle: TextStyle(
              color: Theming.whiteTone.withOpacity(0.5),
            ),
            prefixIcon: const Icon(
              Icons.people_rounded,
              color: Theming.primaryColor,
              size: 32,
            ),
            border: InputBorder.none,
          ),
          style: const TextStyle(
            color: Theming.whiteTone,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget _partyPivacyPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _statusItem(1, "prywatna"),
        _statusItem(2, "publiczna"),
        _statusItem(3, "sekretna"),
      ],
    );
  }

  Widget _statusItem(int index, String caption) {
    bool isSelected = partyStatus == index;

    return GestureDetector(
      onTap: () {
        setState(() => partyStatus = index);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theming.whiteTone.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Theming.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          caption,
          style: const TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
