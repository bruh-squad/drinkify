import 'package:flutter/material.dart';

import '../widgets/loginpage/app_intro.dart';
import '../widgets/loginpage/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: PageController(initialPage: 1),
      children: const [
        AppIntro(),
        LoginForm(),
      ],
    );
  }
}

enum FormType {
  login,
  register,
}
