import 'package:flutter/material.dart';

import '/utils/theming.dart';

class CreatePartyDialog extends StatelessWidget {
  const CreatePartyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final Size dialogSize = Size(MediaQuery.of(context).size.width - 80, 200);

    return Dialog(
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
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: const Icon(
                  Icons.edit_calendar_outlined,
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
                  children: const [
                    Spacer(),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
