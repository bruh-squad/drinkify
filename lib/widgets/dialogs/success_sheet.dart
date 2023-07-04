import 'package:flutter/material.dart';

import '/utils/theming.dart';

class SuccessSheet extends StatelessWidget {
  final bool success;
  final String successMsg;
  final String failureMsg;
  const SuccessSheet({
    required this.success,
    required this.successMsg,
    required this.failureMsg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Wrap(
            alignment: WrapAlignment.center,
            // direction: Axis.vertical,
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 5,
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: success ? Theming.greenTone : Theming.errorColor,
                ),
                child: Icon(
                  success ? Icons.check_rounded : Icons.close_rounded,
                  size: MediaQuery.of(context).size.width / 9,
                  color: Theming.whiteTone,
                ),
              ),
              const SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                success ? successMsg : failureMsg,
                style: const TextStyle(
                  color: Theming.whiteTone,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
