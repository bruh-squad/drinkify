import 'package:drinkify/controllers/auth_controller.dart';
import 'package:drinkify/models/create_user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../utils/locale_support.dart';
import '../utils/theming.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int? selectedFieldIndex;

  var usernameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var firstNameCtrl = TextEditingController();
  var lastNameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var passwordConfirmCtrl = TextEditingController();
  DateTime? dateOfBirthVal;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  void dispose() {
    super.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    passwordCtrl.dispose();
    passwordConfirmCtrl.dispose();
  }

  bool get _userCanRegister {
    final List<dynamic> fieldCtrls = [
      usernameCtrl.text,
      emailCtrl.text,
      firstNameCtrl.text,
      lastNameCtrl.text,
      passwordCtrl.text,
      passwordConfirmCtrl.text,
      dateOfBirthVal,
    ];
    for (final i in fieldCtrls) {
      if (i == "" || i == null) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);
    AuthController authController = AuthController();

    return Scaffold(
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
                Text(
                  transl.signUp,
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
                Center(
                  child: GestureDetector(
                    onTap: () {
                      //TODO picking an image from gallery
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0x9F000E1F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Theming.bgColorLight,
                            backgroundImage:
                                AssetImage("assets/images/default_pfp.png"),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            transl.changePfp,
                            style: const TextStyle(
                              color: Theming.whiteTone,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                _editField(
                  0,
                  caption: transl.username,
                  icon: Icons.alternate_email_rounded,
                  placeholder: transl.usernameField,
                  ctrl: usernameCtrl,
                ),
                _editField(
                  1,
                  caption: transl.email,
                  icon: Icons.email_outlined,
                  placeholder: transl.emailField,
                  ctrl: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _editField(
                      2,
                      caption: transl.firstName,
                      icon: Icons.person_pin_rounded,
                      placeholder: transl.firstNameField,
                      ctrl: firstNameCtrl,
                      manyInRow: true,
                      keyboardType: TextInputType.name,
                    ),
                    _editField(
                      3,
                      caption: transl.lastName,
                      icon: Icons.contact_emergency_rounded,
                      placeholder: transl.lastNameField,
                      ctrl: lastNameCtrl,
                      manyInRow: true,
                      keyboardType: TextInputType.name,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _editField(
                      4,
                      caption: transl.password,
                      icon: Icons.lock_outline,
                      placeholder: transl.passwordField,
                      ctrl: passwordCtrl,
                      isPassword: true,
                      manyInRow: true,
                    ),
                    _editField(
                      5,
                      caption: transl.confirmPassword,
                      icon: Icons.lock_outline,
                      placeholder: transl.passwordField,
                      ctrl: passwordConfirmCtrl,
                      isPassword: true,
                      manyInRow: true,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() => selectedFieldIndex = null);
                      var dateVal = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 100),
                        lastDate: DateTime.now(),
                        useRootNavigator: true,
                        locale: Locale(transl.localeName),
                      );
                      setState(() => dateOfBirthVal = dateVal);
                    },
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0x9F000E1F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.date_range_outlined,
                            color: Theming.whiteTone,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            dateOfBirthVal == null
                                ? transl.dateOfBirth
                                : DateFormat.yMd(transl.localeName)
                                    .format(dateOfBirthVal!),
                            style: const TextStyle(
                              color: Theming.whiteTone,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      authController.registerUser(
                        CreateUser(
                          username: usernameCtrl.text,
                          email: emailCtrl.text,
                          firstName: firstNameCtrl.text,
                          lastName: lastNameCtrl.text,
                          dateOfBirth:
                              dateOfBirthVal!, //TODO fix the NULL value
                          password: passwordCtrl.text,
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      width: double.infinity,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linearToEaseOut,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: _userCanRegister
                            ? Theming.primaryColor
                            : Theming.whiteTone.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        transl.signUp,
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
                Center(
                  child: GestureDetector(
                    onTap: () => context.go("/login"),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: transl.haveAnAccount,
                            style: TextStyle(
                              color: Theming.whiteTone.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: " ${transl.signIn}",
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
    bool manyInRow = false,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    const double radius = 10;
    const double iconSize = 24;

    bool isSelected = index == selectedFieldIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Stack(
        children: [
          AnimatedContainer(
            height: 60,
            width: manyInRow
                ? MediaQuery.of(context).size.width / 2 - 30 - 10
                : double.infinity,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
            decoration: BoxDecoration(
              color: Theming.bgColor,
              border: Border.all(
                width: 1.5,
                color: isSelected
                    ? Theming.primaryColor
                    : Theming.whiteTone.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: TextField(
              onTap: () {
                setState(() => selectedFieldIndex = index);
              },
              obscureText: isPassword,
              keyboardType: keyboardType,
              style: TextStyle(
                  color: Theming.whiteTone, letterSpacing: isPassword ? 6 : 0),
              cursorColor: Theming.primaryColor,
              controller: ctrl,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0,
                  color: isSelected
                      ? Theming.whiteTone.withOpacity(0.4)
                      : Colors.transparent,
                ),
                prefixIcon: Icon(
                  icon,
                  color: isSelected
                      ? Theming.primaryColor
                      : Theming.whiteTone.withOpacity(0.2),
                  size: iconSize,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          AnimatedPadding(
            padding: EdgeInsets.only(
              top: isSelected || ctrl.text.isNotEmpty ? 0 : 30,
              left: iconSize * 2,
              bottom: isSelected || ctrl.text.isNotEmpty ? 0 : 10,
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
            child: Container(
              color: Theming.bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 5),
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
        ],
      ),
    );
  }
}
