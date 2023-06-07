import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/party.dart';
import '/utils/theming.dart';
import '/utils/ext.dart' show MapUtils;
import '/utils/locale_support.dart';
import '/widgets/dialogs/no_maps_dialog.dart';

late AppLocalizations transl;

class PartyHeader extends StatefulWidget {
  final Party party;
  const PartyHeader({
    required this.party,
    super.key,
  });

  @override
  State<PartyHeader> createState() => _PartyHeaderState();
}

class _PartyHeaderState extends State<PartyHeader> with MapUtils {
  String partyLocation = "";

  void _getActualLocation(LatLng latLng, BuildContext ctx) async {
    transl = LocaleSupport.appTranslates(ctx);
    List<Placemark> placemarks = [];

    try {
      placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
    } catch (_) {
      partyLocation = transl.unknown;
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
    if (mounted) {
      setState(
        () => partyLocation = "${place.country}, $locArea, ${place.street}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _getActualLocation(widget.party.location, context);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 110),
      decoration: const BoxDecoration(
        color: Theming.bgColor,
        boxShadow: [
          BoxShadow(
            color: Theming.bgColor,
            offset: Offset(0, 20),
            spreadRadius: 15,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.party.name,
            style: Styles.partyHeaderTitle,
            maxLines: 1,
          ),
          GestureDetector(
            onTap: () async {
              bool succeded = await openMap(
                lat: widget.party.location.latitude,
                lng: widget.party.location.longitude,
              );

              if (!succeded) {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (_) => const NoMapsDialog(),
                  );
                }
              }
            },
            child: Row(
              children: [
                Text(
                  partyLocation,
                  style: Styles.partyHeaderLocation,
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.link_sharp,
                  color: Theming.whiteTone.withOpacity(0.6),
                  size: 18,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          //Party info (date, time, number of people)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Date
              Row(
                children: [
                  const Icon(
                    Icons.date_range_outlined,
                    color: Theming.primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat.yMd(transl.localeName)
                        .format(widget.party.startTime),
                    style: Styles.partyHeaderInfo,
                  ),
                ],
              ),

              //Time
              Row(
                children: [
                  const Icon(
                    Icons.timelapse,
                    color: Theming.primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat.Hm(transl.localeName)
                        .format(widget.party.startTime),
                    style: Styles.partyHeaderInfo,
                  ),
                ],
              ),

              //Number of people participating
              Row(
                children: [
                  const Icon(
                    Icons.group_outlined,
                    color: Theming.primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${widget.party.participants?.length}",
                    style: Styles.partyHeaderInfo,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
