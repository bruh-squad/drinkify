import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/utils/theming.dart';
import '/utils/locale_support.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var usernameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var firstNameCtrl = TextEditingController();
  var lastNameCtrl = TextEditingController();
  var oldPasswordCtrl = TextEditingController();
  var newPasswordCtrl = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);

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
          transl.editProfilePage,
          style: const TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
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
                    minRadius: 20,
                    maxRadius: 55,
                    backgroundColor: Theming.bgColorLight,
                    backgroundImage: NetworkImage(
                      "https://imgs.search.brave.com/Sh1KvzTzy10m30RShyompgGbNefsark8-QTMfC19svY/rs:fit:370:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC54/MWpmLWJTdGJlbkFo/U0poYXdKMmNRSGFK/ZSZwaWQ9QXBp",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
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
                        transl.changePfp,
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
              _editField(
                0,
                caption: transl.username,
                icon: Icons.verified_user_outlined,
                placeholder: transl.usernameField,
                ctrl: usernameCtrl,
              ),
              _editField(
                1,
                caption: transl.email,
                icon: Icons.email_outlined,
                placeholder: transl.emailField,
                ctrl: emailCtrl,
              ),
              _editField(
                2,
                caption: transl.firstName,
                icon: Icons.person_pin_rounded,
                placeholder: transl.firstNameField,
                ctrl: firstNameCtrl,
              ),
              _editField(
                3,
                caption: transl.lastName,
                icon: Icons.person_pin_rounded,
                placeholder: transl.lastNameField,
                ctrl: lastNameCtrl,
              ),
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
                              _editField(
                                4,
                                caption: transl.oldPassword,
                                icon: Icons.lock_outline,
                                placeholder: transl.oldPasswordField,
                                isPassword: true,
                                ctrl: oldPasswordCtrl,
                              ),
                              _editField(
                                5,
                                caption: transl.newPassword,
                                icon: Icons.lock_outline,
                                placeholder: transl.newPasswordField,
                                isPassword: true,
                                ctrl: newPasswordCtrl,
                              ),
                              GestureDetector(
                                onTap: () {},
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
                                    transl.changePassword,
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
                    transl.changePassword,
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

  Widget _editField(
    int index, {
    required String caption,
    required IconData icon,
    required String placeholder,
    required TextEditingController ctrl,
    bool isPassword = false,
  }) {
    const double radius = 20;
    const double iconSize = 24;

    bool isSelected = index == selectedFieldIndex;

    return Stack(
      children: [
        Container(
          height: 70,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0x9F000E1F),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: TextField(
            onSubmitted: (_) {
              setState(() => selectedFieldIndex = null);
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onTap: () {
              setState(() => selectedFieldIndex = index);
            },
            obscureText: isPassword,
            style: const TextStyle(color: Theming.whiteTone),
            cursorColor: Theming.primaryColor,
            controller: ctrl,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 14,
                color: isSelected
                    ? Theming.whiteTone.withOpacity(0.4)
                    : Colors.transparent,
              ),
              prefixIcon: Icon(
                icon,
                color: isSelected ? Theming.primaryColor : Theming.whiteTone,
                size: iconSize,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 80,
          child: AnimatedPadding(
            padding: EdgeInsets.only(
              top: isSelected || ctrl.text.isNotEmpty ? 7 : 0,
              left: iconSize * 2,
              bottom: isSelected || ctrl.text.isNotEmpty ? 0 : 10,
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
            child: AnimatedAlign(
              alignment: isSelected || ctrl.text.isNotEmpty
                  ? Alignment.topLeft
                  : Alignment.centerLeft,
              curve: Curves.linearToEaseOut,
              duration: const Duration(milliseconds: 500),
              child: Text(
                caption,
                style: TextStyle(
                  color: isSelected ? Theming.primaryColor : Theming.whiteTone,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
