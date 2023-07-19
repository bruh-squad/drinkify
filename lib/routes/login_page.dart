import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/theming.dart';
import '../widgets/edit_field.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../widgets/dialogs/success_sheet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;
  late final TextEditingController passwordResetEmailCtrl;
  late bool rememberPassword;
  late int? selectedFieldIndex;

  @override
  void initState() {
    super.initState();
    email = "";
    password = "";
    rememberPassword = false;
    selectedFieldIndex = null;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const storage = FlutterSecureStorage();
      final storageEmail = await storage.read(key: "user_email");
      final storagePassword = await storage.read(key: "user_password");
      final storageRemember = await storage.read(key: "remember");
      if (storageRemember != "true" ||
          storageEmail == null ||
          storagePassword == null) return;
      final loggedIn = await AuthController.loginUser(
        storageEmail,
        storagePassword,
        true,
      );
      if (loggedIn && mounted) context.go("/");
    });
  }

  bool get _userCanLogin {
    return !(email.isEmpty || password.isEmpty);
  }

  void _onFieldSelect(int index) {
    setState(() => selectedFieldIndex = index);
  }

  @override
  Widget build(BuildContext context) {
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
              AppLocalizations.of(context)!.logIn,
              style: const TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 38,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.fillFieldsBelow,
              style: TextStyle(
                color: Theming.whiteTone.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            EditField(
              index: 0,
              selectedFieldIndex: selectedFieldIndex,
              caption: AppLocalizations.of(context)!.email,
              icon: Icons.email_rounded,
              placeholder: AppLocalizations.of(context)!.emailField,
              additionalValue: email,
              keyboardType: TextInputType.emailAddress,
              onSelect: (idx) => _onFieldSelect(idx),
              onType: (val) => email = val,
            ),
            EditField(
              index: 1,
              selectedFieldIndex: selectedFieldIndex,
              caption: AppLocalizations.of(context)!.password,
              icon: Icons.password,
              placeholder: AppLocalizations.of(context)!.passwordField,
              isPassword: true,
              additionalValue: password,
              onSelect: (idx) => _onFieldSelect(idx),
              onType: (val) => password = val,
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
                    AppLocalizations.of(context)!.rememberMe,
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
                onTap: () async {
                  if (_userCanLogin) {
                    final loggedIn = await AuthController.loginUser(
                      email,
                      password,
                      rememberPassword,
                    );
                    final userData = await UserController.me();
                    const storage = FlutterSecureStorage();
                    await storage.write(
                      key: "user_publicId",
                      value: userData.publicId,
                    );
                    if (loggedIn) {
                      if (rememberPassword) {
                        await storage.write(
                          key: "user_email",
                          value: email,
                        );
                        await storage.write(
                          key: "user_password",
                          value: password,
                        );
                      } else {
                        await storage.delete(key: "user_email");
                        await storage.delete(key: "user_password");
                      }
                      if (mounted) context.go("/");
                      return;
                    }
                    if (!mounted) return;
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Theming.bgColor,
                      builder: (ctx) => SuccessSheet(
                        success: false,
                        successMsg: AppLocalizations.of(context)!.loginFailed,
                        failureMsg: AppLocalizations.of(context)!.loginFailed,
                      ),
                    );
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
                    AppLocalizations.of(context)!.logIn,
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
                        text: AppLocalizations.of(context)!.dontHaveAnAccount,
                        style: TextStyle(
                          color: Theming.whiteTone.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: " ${AppLocalizations.of(context)!.signUp}",
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
