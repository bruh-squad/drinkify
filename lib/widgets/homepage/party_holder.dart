import 'package:flutter/material.dart';

class PartyHolder extends StatelessWidget {
  // final Party party;
  const PartyHolder({
    // this.party,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://imgs.search.brave.com/YHgUwH38lZPKckWM3Nd6VG0JzmN8NOT6vvWvgHHSDsQ/rs:fit:1200:1080:1/g:ce/aHR0cHM6Ly9jZG4u/d2FsbHBhcGVyc2Fm/YXJpLmNvbS8xNi8x/MC9uRnpZZ2wuanBn",
              ),
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(),
        ),
      ],
    );
  }
}
