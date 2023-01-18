import 'package:flutter/material.dart';

class PartyList extends StatelessWidget {
  const PartyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Imprezy'),
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              child: Text("Test", style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
      ],
    );
  }
}
