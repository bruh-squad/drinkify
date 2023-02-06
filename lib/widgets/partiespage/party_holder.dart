import 'package:flutter/material.dart';
import 'package:drinkify/models/party_model.dart';
import 'package:go_router/go_router.dart';

import '../../utils/theming.dart';

class PartyHolder extends StatefulWidget {
  final List<Party> partyList;
  const PartyHolder({super.key, required this.partyList});

  @override
  State<PartyHolder> createState() => _PartyHolderState();
}

class _PartyHolderState extends State<PartyHolder> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 540,
      child: (widget.partyList.isNotEmpty)
          ? ListView.builder(
              itemCount: widget.partyList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: _partyListItem(index),
                  onTap: () {
                    return context.go(
                      '/party',
                      extra: widget.partyList[index],
                    );
                  },
                );
              },
            )
          : Center(
              child: Text(
                "Brak imprez",
                style: Styles.emptyListText,
              ),
            ),
    );
  }

  Widget _partyListItem(int idx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theming.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        widget.partyList[idx].name,
        style: const TextStyle(
          color: Theming.whiteTone,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
