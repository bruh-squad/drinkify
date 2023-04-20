import 'package:drinkify/utils/locale_support.dart';
import 'package:flutter/material.dart';

import '/utils/theming.dart';

class NoMapsDialog extends StatelessWidget {
  const NoMapsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var transl = LocaleSupport.appTranslates(context);

    final Size dialogSize = Size(MediaQuery.of(context).size.width - 80, 200);

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
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
                  width: dialogSize.width / 4,
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
                    Icons.close_rounded,
                    color: Theming.whiteTone,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transl.error,
                        style: const TextStyle(
                          color: Theming.whiteTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        width: dialogSize.width / 4 * 3 - 35,
                        child: Text(
                          transl.mapError,
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
