import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '/utils/theming.dart';

final Color errorColor = Colors.red.withOpacity(0.3);

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
  late List<int> errorFields;

  int subPageIndex = 0;

  var titleCtrl = TextEditingController();
  var peopleCountCtrl = TextEditingController();
  int partyStatus = 1; //1: private  2: public  3: secret

  @override
  void initState() {
    super.initState();
    errorFields = [];
  }

  Widget get _subPage {
    switch (subPageIndex) {
      case 0:
        return _peopleCountPage(1);
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
                vertical: 15,
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
                  const SizedBox(height: 20),

                  //Title
                  _categoryText("Tytuł"),

                  Flexible(
                    flex: 0,
                    child: _titleField(0),
                  ),
                  const SizedBox(height: 40),

                  _pageSwitcher(),

                  Flexible(
                    flex: 2,
                    child: _subPage,
                  ),

                  _categoryText("Lokalizacja"),
                  Flexible(
                    flex: 0,
                    child: SizedBox(
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
                  ),
                ],
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navButton(
                  context,
                  topLeftRightPadding,
                  backgroundColor: Theming.whiteTone,
                  text: const Text(
                    "Zamknij",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                _navButton(
                  context,
                  topLeftRightPadding,
                  backgroundColor: Theming.primaryColor,
                  text: const Text(
                    "Dalej",
                    style: TextStyle(
                      color: Theming.whiteTone,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    setState(() => errorFields = []);
                    final List<TextEditingController> fields = [
                      titleCtrl,
                      peopleCountCtrl,
                    ];
                    for (int i = 0; i < fields.length; i++) {
                      if (fields[i].text == "") {
                        setState(() => errorFields.add(i));
                      }
                    }
                    if (errorFields.isNotEmpty) return;
                    widget.onNext(
                      titleCtrl,
                      peopleCountCtrl,
                      partyStatus,
                      1,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleField(int index) {
    bool isError = false;
    for (final i in errorFields) {
      if (i == index) {
        setState(() => isError = true);
        break;
      }
    }
    return Container(
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: isError ? errorColor : Theming.whiteTone.withOpacity(0.1),
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

  Widget _peopleCountPage(int index) {
    bool isError = false;
    for (final i in errorFields) {
      if (i == index) {
        setState(() => isError = true);
        break;
      }
    }
    return Center(
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 25 * 2 - 30 * 2 - 150,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: isError ? errorColor : Theming.whiteTone.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: peopleCountCtrl,
          cursorColor: Theming.primaryColor,
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: true,
          ),
          decoration: InputDecoration(
            hintText: "Liczba osób",
            hintStyle: TextStyle(
              color: Theming.whiteTone.withOpacity(0.5),
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

  Widget _navButton(
    BuildContext ctx,
    double padding, {
    required Color backgroundColor,
    required Text text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: (MediaQuery.of(ctx).size.width - padding * 2) / 2 - 10,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: text,
      ),
    );
  }
}
