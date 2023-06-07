import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/theming.dart';
import '../utils/locale_support.dart';
import '../widgets/edit_field.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthController authCtrl;
  late final TextEditingController passwordResetEmailCtrl;
  late bool rememberPassword;
  late int? selectedFieldIndex;

  @override
  void initState() {
    super.initState();
    authCtrl = AuthController();
    passwordResetEmailCtrl = TextEditingController();
    rememberPassword = false;
    selectedFieldIndex = null;
  }

  @override
  void dispose() {
    super.dispose();
    authCtrl.emailCtrl.dispose();
    authCtrl.passwordCtrl.dispose();
    passwordResetEmailCtrl.dispose();
  }

  bool get _userCanLogin {
    return !(authCtrl.emailCtrl.text == "" || authCtrl.passwordCtrl.text == "");
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
                color: Theming.whiteTone.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            EditField(
              index: 0,
              selectedFieldIndex: selectedFieldIndex,
              caption: transl.email,
              icon: Icons.email_outlined,
              placeholder: transl.emailField,
              ctrl: authCtrl.emailCtrl,
              keyboardType: TextInputType.emailAddress,
              onSelect: (idx) => setState(() => selectedFieldIndex = idx),
            ),
            EditField(
              index: 1,
              selectedFieldIndex: selectedFieldIndex,
              caption: transl.password,
              icon: Icons.lock_outline,
              placeholder: transl.passwordField,
              ctrl: authCtrl.passwordCtrl,
              isPassword: true,
              onSelect: (idx) => setState(() => selectedFieldIndex = idx),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() => rememberPassword = !rememberPassword);
              },
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.5,
                            color: Theming.whiteTone.withOpacity(0.2),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: AnimatedContainer(
                            height: rememberPassword ? 20 : 0,
                            width: rememberPassword ? 20 : 0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.bounceInOut,
                            decoration: const BoxDecoration(
                              color: Theming.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 150),
                            opacity: rememberPassword ? 1 : 0,
                            curve: Curves.bounceInOut,
                            child: const Icon(
                              Icons.check_rounded,
                              color: Theming.whiteTone,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5),
                  Text(
                    transl.rememberMe,
                    style: TextStyle(
                      color: Theming.whiteTone.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (_userCanLogin) {
                    authCtrl.loginUser();
                  }
                },
                child: AnimatedContainer(
                  width: double.infinity,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linearToEaseOut,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: _userCanLogin
                        ? Theming.primaryColor
                        : Theming.whiteTone.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
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
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
