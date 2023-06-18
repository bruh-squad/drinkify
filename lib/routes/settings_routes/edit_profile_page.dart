import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/utils/theming.dart';
import '/widgets/edit_field.dart';
import '/widgets/custom_floating_button.dart';
import '/widgets/dialogs/edit_profile_confirmation.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController usernameCtrl;
  late final TextEditingController emailCtrl;
  late final TextEditingController firstNameCtrl;
  late final TextEditingController lastNameCtrl;
  late final TextEditingController oldPasswordCtrl;
  late final TextEditingController newPasswordCtrl;

  late int? selectedFieldIndex;

  @override
  void initState() {
    super.initState();
    usernameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    firstNameCtrl = TextEditingController();
    lastNameCtrl = TextEditingController();
    oldPasswordCtrl = TextEditingController();
    newPasswordCtrl = TextEditingController();
    selectedFieldIndex = null;
  }

  @override
  void dispose() {
    super.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    oldPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
  }

  void _onFieldSelect(int index) {
    setState(() => selectedFieldIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      appBar: AppBar(
        backgroundColor: Theming.bgColor,
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
        title: Text(
          AppLocalizations.of(context)!.editProfilePage,
          style: const TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: CustomFloatingButton(
        caption: AppLocalizations.of(context)!.save,
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => const EditProfileConfirmation(),
          );
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: Theming.bgColorLight,
                    backgroundImage: NetworkImage(
                      "https://imgs.search.brave.com/Sh1KvzTzy10m30RShyompgGbNefsark8-QTMfC19svY/rs:fit:370:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC54/MWpmLWJTdGJlbkFo/U0poYXdKMmNRSGFK/ZSZwaWQ9QXBp",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ///TODO implement image picking
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x9F000E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.changePfp,
                        style: const TextStyle(
                          color: Theming.whiteTone,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              EditField(
                index: 0,
                caption: AppLocalizations.of(context)!.username,
                icon: Icons.verified_user_outlined,
                placeholder: AppLocalizations.of(context)!.usernameField,
                ctrl: usernameCtrl,
                onSelect: (idx) => _onFieldSelect(idx),
                selectedFieldIndex: selectedFieldIndex,
              ),
              EditField(
                index: 1,
                caption: AppLocalizations.of(context)!.email,
                icon: Icons.email_outlined,
                placeholder: AppLocalizations.of(context)!.emailField,
                ctrl: emailCtrl,
                onSelect: (idx) => _onFieldSelect(idx),
                selectedFieldIndex: selectedFieldIndex,
              ),
              EditField(
                index: 2,
                caption: AppLocalizations.of(context)!.firstName,
                icon: Icons.person_pin_rounded,
                placeholder: AppLocalizations.of(context)!.firstNameField,
                ctrl: firstNameCtrl,
                selectedFieldIndex: selectedFieldIndex,
                onSelect: (idx) => _onFieldSelect(idx),
              ),
              EditField(
                index: 3,
                caption: AppLocalizations.of(context)!.lastName,
                icon: Icons.person_pin_rounded,
                placeholder: AppLocalizations.of(context)!.lastNameField,
                ctrl: lastNameCtrl,
                selectedFieldIndex: selectedFieldIndex,
                onSelect: (idx) => _onFieldSelect(idx),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Theming.bgColor,
                    enableDrag: false,
                    isScrollControlled: true,
                    builder: (ctx) {
                      return SizedBox(
                        height: MediaQuery.of(ctx).size.height / 1.3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 30,
                          ),
                          child: Column(
                            children: [
                              EditField(
                                index: 4,
                                caption:
                                    AppLocalizations.of(context)!.oldPassword,
                                icon: Icons.lock_outline,
                                placeholder: AppLocalizations.of(context)!
                                    .oldPasswordField,
                                isPassword: true,
                                ctrl: oldPasswordCtrl,
                                onSelect: (idx) => _onFieldSelect(idx),
                              ),
                              EditField(
                                index: 5,
                                caption:
                                    AppLocalizations.of(context)!.newPassword,
                                icon: Icons.lock_outline,
                                placeholder: AppLocalizations.of(context)!
                                    .newPasswordField,
                                isPassword: true,
                                ctrl: newPasswordCtrl,
                                onSelect: (idx) => _onFieldSelect(idx),
                              ),
                              GestureDetector(
                                onTap: () {
                                  //TODO impletment changing password
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theming.primaryColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .changePassword,
                                    style: const TextStyle(
                                      color: Theming.whiteTone,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0x9F000E1F),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.changePassword,
                    style: const TextStyle(
                      color: Theming.whiteTone,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 66),
            ],
          ),
        ),
      ),
    );
  }
}
