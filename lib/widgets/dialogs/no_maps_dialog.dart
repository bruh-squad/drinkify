import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';

class NoMapsDialog extends StatelessWidget {
  const NoMapsDialog({super.key});

  Size dialogSize(BuildContext ctx) {
    return Size(
      MediaQuery.of(ctx).size.width - 80,
      200,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Dialog(
        backgroundColor: Theming.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: SizedBox(
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: dialogSize(context).width / 4,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: const Icon(
                    Icons.sentiment_dissatisfied_rounded,
                    color: Theming.whiteTone,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.error,
                        style: const TextStyle(
                          color: Theming.whiteTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: dialogSize(context).width / 4 * 3 - 35,
                        child: Text(
                          AppLocalizations.of(context)!.mapError,
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
