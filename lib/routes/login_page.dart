import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/theming.dart';
import '../utils/locale_support.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var passwordResetEmailCtrl = TextEditingController();

  late int? selectedFieldIndex;

  @override
  void initState() {
    super.initState();
    selectedFieldIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theming.bgColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: MediaQuery.of(context).viewInsets.top + 70,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transl.logIn,
              style: const TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 38,
              ),
            ),
            Text(
              transl.fillFieldsBelow,
              style: TextStyle(
                color: Theming.whiteTone.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            _editField(
              0,
              caption: transl.email,
              icon: Icons.email_outlined,
              placeholder: transl.emailField,
              ctrl: emailCtrl,
            ),
            _editField(
              1,
              caption: transl.password,
              icon: Icons.lock_outline,
              placeholder: transl.passwordField,
              ctrl: passwordCtrl,
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
                  child: Text(
                    transl.logIn,
                    style: const TextStyle(
                      color: Theming.whiteTone,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
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
                              Text(
                                transl.passwordReset,
                                style: const TextStyle(
                                  color: Theming.whiteTone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 30),
                              _editField(
                                2,
                                caption: transl.email,
                                icon: Icons.email_outlined,
                                placeholder: transl.emailField,
                                ctrl: passwordResetEmailCtrl,
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
                                    transl.resetPassword,
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
                child: Text(
                  transl.forgotPassword,
                  style: const TextStyle(
                    color: Theming.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () => context.go("/register"),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: transl.dontHaveAnAccount,
                          style: TextStyle(
                            color: Theming.whiteTone.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: " ${transl.signUp}",
                          style: const TextStyle(
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
            ),
            const SizedBox(height: 30),
          ],
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
