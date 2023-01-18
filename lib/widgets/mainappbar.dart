import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Siema, ${username}',
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Masz 5 powiadomień!",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              const CircleAvatar(
                backgroundColor: Colors.lightGreen,
                radius: 31,
              )
            ],
          ),
        ),
      ],
    );
  }
}
