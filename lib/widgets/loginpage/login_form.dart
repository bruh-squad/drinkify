import 'package:flutter/material.dart';

import '/utils/theming.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: 45,
          right: 45,
          top: MediaQuery.of(context).padding.top + 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //Return button
                Container(
                  child: const Icon(Icons.arrow_back_ios),
                ),
                const Text(
                  "Zaloguj się",
                  style: TextStyle(
                    color: Theming.whiteTone,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            _customTextField(
              caption: "Email",
              icon: Icons.email,
              controller: emailCtrl,
              isPassword: false,
            ),
            _customTextField(
              caption: "Hasło",
              icon: Icons.lock,
              controller: passwordCtrl,
              isPassword: true,
            ),
            GestureDetector(
              onTap: () {
                //Log in
              },
              child: Container(
                height: 55,
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Theming.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Zaloguj się",
                  style: Styles.buttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customTextField({
    required String caption,
    required IconData icon,
    required TextEditingController controller,
    required bool isPassword,
  }) {
    bool isTextHidden = isPassword;

    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width - 45 * 2,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theming.whiteTone.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theming.whiteTone.withOpacity(0.5)),
      ),
      child: TextField(
        cursorColor: Theming.primaryColor,
        obscureText: isTextHidden,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Theming.whiteTone,
        ),
        controller: controller,
        decoration: InputDecoration(
          hintText: caption,
          hintStyle: Styles.loginFormHintText,
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            size: 32,
            color: Theming.whiteTone,
          ),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isTextHidden = !isTextHidden;
                    });
                  },
                  child: Icon(
                    isTextHidden ? Icons.visibility_off : Icons.visibility,
                    color: Theming.whiteTone,
                  ),
                )
              : const SizedBox(height: 0, width: 0),
        ),
      ),
    );
  }
}
