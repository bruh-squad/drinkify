import 'package:flutter/material.dart';

import '/utils/theming.dart';

class CreatePartyDialog extends StatelessWidget {
  const CreatePartyDialog({super.key});

  Size _dialogSize(BuildContext ctx) {
    return Size(
      MediaQuery.of(ctx).size.width - 80,
      200,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                width: _dialogSize(context).width / 4,
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
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 10,
                ),
                child: Column(
                  children: [
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
