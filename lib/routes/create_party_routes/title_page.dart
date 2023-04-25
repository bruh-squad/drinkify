import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';

import '/utils/theming.dart';
import '/utils/locale_support.dart';
import '../create_party_routes/choose_location_page.dart';
import '/widgets/glass_morphism.dart';

late AppLocalizations transl;

final Color errorColor = Colors.red.withOpacity(0.3);
typedef TEC = TextEditingController;

//Moved outside the class to let the values stay after the page was switched
var titleCtrl = TEC();
var peopleCountCtrl = TEC();
int partyStatus = 1; //1: private  2: public  3: secret
String formattedPartyLocation = ""; //format: POINT(lat lng)

String? textLocation;
LatLng? savedLocation;

class TitlePage extends StatefulWidget {
  /// * title controller, people count controller, party status, formatted location, next page index
  final Function(TEC, TEC, int, String, int) onNext;
  const TitlePage({
    required this.onNext,
    super.key,
  });

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  late final MapController mapCtrl;
  late List<int> errorFields;

  /// * 0 = people count page; 1 = party status page
  late int subPageIndex;

  /// * 0 = none; 1 = title; 2 = people count
  late int selectedFieldIndex;

  @override
  void initState() {
    super.initState();
    errorFields = [];
    subPageIndex = 0;
    selectedFieldIndex = 0;
    mapCtrl = MapController();
  }

  @override
  void dispose() {
    super.dispose();
    mapCtrl.dispose();
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
        return transl.numberOfPeople;
      default:
        return transl.partyStatus;
    }
  }

  void _getActualLocation(LatLng latLng, BuildContext ctx) async {
    List<Placemark> placemarks = [];

    try {
      placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
    } catch (_) {
      textLocation = transl.unknown;
      return;
    }
    Placemark place = placemarks[0];

    final cityFields = <String>[
      place.locality!,
      place.administrativeArea!,
      place.subAdministrativeArea!,
      place.subLocality!,
    ];

    String locArea = "";

    for (final i in cityFields) {
      if (i != "") {
        locArea = i;
        break;
      }
    }
    bool addComma = locArea != "";

    if (mounted) {
      setState(() {
        textLocation = "${place.country}, $locArea${addComma ? ", " : ""}${place.street}";
        mapCtrl.move(
          LatLng(latLng.latitude, latLng.longitude),
          15,
        );
      });
      savedLocation = latLng;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double topLeftRightPadding = 15;
    transl = LocaleSupport.appTranslates(context);

    return Scaffold(
      backgroundColor: Theming.bgColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top + 40),
            //Title
            _categoryText(transl.title),

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

            _locationButton(2, context),
            const SizedBox(height: 30),

            Container(
              height: 100 + MediaQuery.of(context).viewPadding.bottom,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navButton(
                    context,
                    topLeftRightPadding,
                    backgroundColor: Theming.whiteTone,
                    text: Text(
                      transl.close,
                      style: const TextStyle(
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
                    text: Text(
                      transl.next,
                      style: const TextStyle(
                        color: Theming.whiteTone,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      setState(() => errorFields = []);
                      final List<dynamic> fields = [
                        titleCtrl,
                        peopleCountCtrl,
                        formattedPartyLocation,
                      ];
                      for (int i = 0; i < fields.length; i++) {
                        if (fields[i] is TEC) {
                          if (fields[i].text == "") {
                            setState(() => errorFields.add(i));
                          }
                        }
                        if (fields[i] is String) {
                          if (fields[i] == "") {
                            setState(() => errorFields.add(i));
                          }
                        }
                      }
                      if (errorFields.isNotEmpty) return;
                      widget.onNext(
                        titleCtrl,
                        peopleCountCtrl,
                        partyStatus,
                        formattedPartyLocation,
                        1,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleField(int index) {
    bool isSelected = selectedFieldIndex == 1;

    bool isError = false;
    for (final i in errorFields) {
      if (i == index) {
        setState(() => isError = true);
        break;
      }
    }
    return AnimatedContainer(
      width: double.infinity,
      height: 60,
      curve: Curves.linearToEaseOut,
      duration: const Duration(milliseconds: 250),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: isError ? errorColor : Theming.whiteTone.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isSelected ? Theming.primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: TextField(
        onTap: () {
          setState(() => selectedFieldIndex = 1);
        },
        cursorColor: Theming.primaryColor,
        controller: titleCtrl,
        style: const TextStyle(
          color: Theming.whiteTone,
        ),
        decoration: InputDecoration(
          hintText: transl.addPartyTitle,
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
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: subPageIndex != 0 ? 1 : 0,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theming.primaryColor,
            ),
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
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: subPageIndex != maxPages - 1 ? 1 : 0,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theming.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _peopleCountPage(int index) {
    bool isSelected = selectedFieldIndex == 2;

    bool isError = false;
    for (final i in errorFields) {
      if (i == index) {
        setState(() => isError = true);
        break;
      }
    }

    return Center(
      child: AnimatedContainer(
        height: 66,
        width: 120,
        curve: Curves.linearToEaseOut,
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: isError ? errorColor : Theming.whiteTone.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? Theming.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: TextField(
          onTap: () {
            setState(() => selectedFieldIndex = 2);
          },
          controller: peopleCountCtrl,
          cursorColor: Theming.primaryColor,
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: true,
          ),
          decoration: InputDecoration(
            hintText: "0",
            hintStyle: TextStyle(
              color: Theming.whiteTone.withOpacity(0.5),
            ),
            border: InputBorder.none,
          ),
          style: const TextStyle(
            color: Theming.whiteTone,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget _partyPivacyPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _statusItem(1, transl.private),
        _statusItem(2, transl.public),
        _statusItem(3, transl.secret),
      ],
    );
  }

  Widget _statusItem(int index, String caption) {
    bool isSelected = partyStatus == index;

    return GestureDetector(
      onTap: () {
        setState(() => partyStatus = index);
      },
      child: AnimatedContainer(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        duration: const Duration(milliseconds: 250),
        curve: Curves.linearToEaseOut,
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

  Widget _locationButton(int index, BuildContext ctx) {
    bool isError = false;
    for (final i in errorFields) {
      if (i == index) {
        setState(() => isError = true);
        break;
      }
    }
    const widgetAspectRatio = 16 / 4.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transl.location,
          style: TextStyle(
            color: isError ? Colors.red : Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Flexible(
          flex: 0,
          child: Stack(
            children: [
              Visibility(
                visible: textLocation != null,
                child: GlassMorphism(
                  blur: 20,
                  opacity: 0.1,
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AspectRatio(
                        aspectRatio: widgetAspectRatio,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Theming.primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Text(textLocation ?? ""),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: widgetAspectRatio,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FlutterMap(
                    mapController: mapCtrl,
                    options: MapOptions(
                      center: savedLocation ?? LatLng(0, 80),
                      zoom: savedLocation == null ? 0 : 15,
                      interactiveFlags: InteractiveFlag.all - InteractiveFlag.all,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                milliseconds: 100,
                              ),
                              reverseTransitionDuration: const Duration(
                                milliseconds: 100,
                              ),
                              transitionsBuilder: (_, a, __, c) {
                                return FadeTransition(
                                  opacity: a,
                                  child: c,
                                );
                              },
                              pageBuilder: (_, __, ___) {
                                return ChooseLocationPage(
                                  onSave: (point, latLng) {
                                    formattedPartyLocation = point;
                                    _getActualLocation(latLng, ctx);
                                  },
                                );
                              },
                            ),
                          );
                        },
                        child: TileLayer(
                          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: "app.drinkify",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
        height: 50,
        width: (MediaQuery.of(ctx).size.width - padding * 2) / 2 - 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: text,
      ),
    );
  }
}
