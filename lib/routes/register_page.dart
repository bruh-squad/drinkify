import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/theming.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int? selectedFieldIndex;

  var emailCtrl = TextEditingController();
  var usernameCtrl = TextEditingController();
  var firstNameCtrl = TextEditingController();
  var lastNameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var passwordConfirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theming.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Zarejestruj się",
                  style: TextStyle(
                    color: Theming.whiteTone,
                    fontWeight: FontWeight.bold,
                    fontSize: 38,
                  ),
                ),
                Text(
                  "Wypełnij poniższe pola, aby kontynuować.",
                  style: TextStyle(
                    color: Theming.whiteTone.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //TODO: implement picking an image from gallery
                        },
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Theming.bgColorLight,
                          backgroundImage: NetworkImage(
                            "https://imgs.search.brave.com/Sh1KvzTzy10m30RShyompgGbNefsark8-QTMfC19svY/rs:fit:370:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC54/MWpmLWJTdGJlbkFo/U0poYXdKMmNRSGFK/ZSZwaWQ9QXBp",
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Theming.bgColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit_outlined,
                              color: Theming.primaryColor,
                              size: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                _editField(
                  0,
                  caption: "E-mail",
                  icon: Icons.email_outlined,
                  placeholder: "Podaj e-mail",
                  ctrl: emailCtrl,
                ),
                _editField(
                  1,
                  caption: "Nazwa użytkownika",
                  icon: Icons.verified_user_outlined,
                  placeholder: "Podaj nazwę użytkownika",
                  ctrl: usernameCtrl,
                ),
                _editField(
                  2,
                  caption: "Imię",
                  icon: Icons.person_pin_rounded,
                  placeholder: "Podaj imię",
                  ctrl: firstNameCtrl,
                ),
                _editField(
                  3,
                  caption: "Nazwisko",
                  icon: Icons.person_pin_rounded,
                  placeholder: "Podaj nazwisko",
                  ctrl: lastNameCtrl,
                ),
                _editField(
                  4,
                  caption: "Hasło",
                  icon: Icons.lock_outline,
                  placeholder: "Podaj hasło",
                  ctrl: passwordCtrl,
                  isPassword: true,
                ),
                _editField(
                  5,
                  caption: "Potwierdź hasło",
                  icon: Icons.lock_outline,
                  placeholder: "Podaj hasło",
                  ctrl: passwordConfirmCtrl,
                  isPassword: true,
                ),
                Center(
                  child: GestureDetector(
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
                      child: const Text(
                        "Zarejestruj się",
                        style: TextStyle(
                          color: Theming.whiteTone,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: GestureDetector(
                    onTap: () => context.go("/login"),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Masz już konto? ",
                            style: TextStyle(
                              color: Theming.whiteTone.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                          const TextSpan(
                            text: "Zaloguj się",
                            style: TextStyle(
                              color: Theming.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
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
                color: isSelected ? Theming.whiteTone.withOpacity(0.4) : Colors.transparent,
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
              alignment: isSelected || ctrl.text.isNotEmpty ? Alignment.topLeft : Alignment.centerLeft,
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
