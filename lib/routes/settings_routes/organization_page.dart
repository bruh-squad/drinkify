import 'package:drinkify/widgets/dialogs/party_options_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/models/party.dart';
import '/controllers/party_creator_controller.dart';
import '/widgets/partiespage/party_holder.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  late List<Party> ownedParties;
  @override
  void initState() {
    super.initState();
    ownedParties = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final parties = await PartyCreatorController.ownedParties();
      setState(() => ownedParties = parties);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theming.bgColor,
            surfaceTintColor: Theming.bgColor,
            shadowColor: Theming.bgColor,
            pinned: true,
            title: Text(
              AppLocalizations.of(context)!.yourParties,
              style: const TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Theming.whiteTone,
                ),
              ),
            ),
          ),
          for (final p in ownedParties)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: PartyHolder(
                  p,
                  () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Theming.bgColor,
                      builder: (ctx) {
                        return PartyOptionsSheet(p);
                      },
                    );
                  },
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom + 20,
            ),
          ),
        ],
      ),
    );
  }
}
