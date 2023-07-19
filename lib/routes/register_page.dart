import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/theming.dart';
import '../controllers/auth_controller.dart';
import '../models/create_user.dart';
import '../widgets/dialogs/image_picker_sheet.dart';
import '../widgets/edit_field.dart';
import '../widgets/dialogs/success_sheet.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final AuthController authController;
  int? selectedFieldIndex;

  XFile? pfp;
  late final TextEditingController usernameCtrl;
  late final TextEditingController emailCtrl;
  late final TextEditingController firstNameCtrl;
  late final TextEditingController lastNameCtrl;
  late final TextEditingController passwordCtrl;
  late final TextEditingController passwordConfirmCtrl;
  late final TextEditingController birthdayCtrl;
  DateTime? dateOfBirthVal;

  @override
  void initState() {
    super.initState();
    authController = AuthController();
    usernameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    firstNameCtrl = TextEditingController();
    lastNameCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    passwordConfirmCtrl = TextEditingController();
    birthdayCtrl = TextEditingController();
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
    birthdayCtrl.dispose();
  }

  bool get _userCanRegister {
    final List<TextEditingController> fieldCtrls = [
      usernameCtrl,
      emailCtrl,
      firstNameCtrl,
      lastNameCtrl,
      passwordCtrl,
      passwordConfirmCtrl,
      birthdayCtrl,
    ];
    for (final i in fieldCtrls) {
      if (i.text.isEmpty) return false;
    }
    return true;
  }

  void _onFieldSelect(int index) {
    setState(() => selectedFieldIndex = index);
  }

  @override
  Widget build(BuildContext context) {
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
                  AppLocalizations.of(context)!.signUp,
                  style: const TextStyle(
                    color: Theming.whiteTone,
                    fontWeight: FontWeight.bold,
                    fontSize: 38,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.fillFieldsBelow,
                  style: TextStyle(
                    color: Theming.whiteTone.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Theming.bgColor,
                        builder: (ctx) => ImagePickerSheet(
                          onFinish: (img) {
                            setState(() => pfp = img);
                            Navigator.pop(ctx);
                          },
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        pfp == null
                            ? Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Theming.bgColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: Theming.whiteTone.withOpacity(0.3),
                                  ),
                                ),
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 50,
                                  color: Theming.whiteTone.withOpacity(0.3),
                                ),
                              )
                            : CircleAvatar(
                                radius: 45,
                                backgroundColor: Theming.bgColorLight,
                                backgroundImage: FileImage(
                                  File(pfp!.path),
                                ),
                              ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                color: Theming.primaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Theming.bgColor,
                                    spreadRadius: 4,
                                  )
                                ],
                              ),
                              child: const Icon(
                                Icons.photo_camera,
                                color: Theming.whiteTone,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                EditField(
                  index: 0,
                  selectedFieldIndex: selectedFieldIndex,
                  caption: AppLocalizations.of(context)!.username,
                  icon: Icons.alternate_email_rounded,
                  placeholder: AppLocalizations.of(context)!.usernameField,
                  ctrl: usernameCtrl,
                  onSelect: (idx) => _onFieldSelect(idx),
                ),
                EditField(
                  index: 1,
                  selectedFieldIndex: selectedFieldIndex,
                  caption: AppLocalizations.of(context)!.email,
                  icon: Icons.email_rounded,
                  placeholder: AppLocalizations.of(context)!.emailField,
                  ctrl: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  onSelect: (idx) => _onFieldSelect(idx),
                ),
                EditField(
                  index: 2,
                  selectedFieldIndex: selectedFieldIndex,
                  caption: AppLocalizations.of(context)!.firstName,
                  icon: Icons.sentiment_satisfied_rounded,
                  placeholder: AppLocalizations.of(context)!.firstNameField,
                  ctrl: firstNameCtrl,
                  keyboardType: TextInputType.name,
                  onSelect: (idx) => _onFieldSelect(idx),
                ),
                EditField(
                  index: 3,
                  selectedFieldIndex: selectedFieldIndex,
                  caption: AppLocalizations.of(context)!.lastName,
                  icon: Icons.contact_emergency_rounded,
                  placeholder: AppLocalizations.of(context)!.lastNameField,
                  ctrl: lastNameCtrl,
                  keyboardType: TextInputType.name,
                  onSelect: (idx) => _onFieldSelect(idx),
                ),
                EditField(
                  index: 4,
                  selectedFieldIndex: selectedFieldIndex,
                  caption: AppLocalizations.of(context)!.password,
                  icon: Icons.password,
                  placeholder: AppLocalizations.of(context)!.passwordField,
                  ctrl: passwordCtrl,
                  isPassword: true,
                  onSelect: (idx) => _onFieldSelect(idx),
                ),
                EditField(
                  index: 5,
                  selectedFieldIndex: selectedFieldIndex,
                  caption: AppLocalizations.of(context)!.confirmPassword,
                  icon: Icons.password,
                  placeholder: AppLocalizations.of(context)!.passwordField,
                  ctrl: passwordConfirmCtrl,
                  isPassword: true,
                  onSelect: (idx) => _onFieldSelect(idx),
                ),
                EditField(
                  index: 6,
                  caption: AppLocalizations.of(context)!.dateOfBirth,
                  icon: Icons.calendar_month_rounded,
                  isDate: true,
                  ctrl: birthdayCtrl,
                  isDateSelected: birthdayCtrl.text.isNotEmpty,
                  placeholder: AppLocalizations.of(context)!.dateOfBirth,
                  keyboardType: TextInputType.none,
                  selectedFieldIndex: selectedFieldIndex,
                  // keyboardType: TextInputType.none,
                  onSelect: (idx) async {
                    setState(() => selectedFieldIndex = null);
                    final datePickerVal = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 100),
                      lastDate: DateTime.now(),
                      useRootNavigator: true,
                      locale: Locale(
                        AppLocalizations.of(context)!.localeName,
                      ),
                    );
                    if (datePickerVal == null || !mounted) return;

                    final formattedDate = DateFormat.yMd(
                      AppLocalizations.of(context)!.localeName,
                    ).format(datePickerVal);

                    setState(() => birthdayCtrl.text = formattedDate);
                    dateOfBirthVal = datePickerVal;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (_userCanRegister) {
                        final canRegister = await AuthController.registerUser(
                          CreateUser(
                            username: usernameCtrl.text,
                            email: emailCtrl.text,
                            firstName: firstNameCtrl.text,
                            lastName: lastNameCtrl.text,
                            dateOfBirth: dateOfBirthVal!,
                            password: passwordCtrl.text,
                            pfp: pfp != null ? File(pfp!.path) : null,
                          ),
                        );
                        if (canRegister) {
                          final loggedIn = await AuthController.loginUser(
                            emailCtrl.text,
                            passwordCtrl.text,
                            false,
                          );
                          if (!mounted) return;
                          if (loggedIn) {
                            context.go("/");
                          } else {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Theming.bgColor,
                              builder: (ctx) => SuccessSheet(
                                success: false,
                                successMsg:
                                    AppLocalizations.of(context)!.loginFailed,
                                failureMsg:
                                    AppLocalizations.of(context)!.loginFailed,
                              ),
                            );
                          }
                          return;
                        }
                        if (!mounted) return;
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Theming.bgColor,
                          builder: (ctx) => SuccessSheet(
                            success: false,
                            successMsg: AppLocalizations.of(context)!
                                .registrationFailed,
                            failureMsg: AppLocalizations.of(context)!
                                .registrationFailed,
                          ),
                        );
                      }
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
                        AppLocalizations.of(context)!.signUp,
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
                            text: AppLocalizations.of(context)!.haveAnAccount,
                            style: TextStyle(
                              color: Theming.whiteTone.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: " ${AppLocalizations.of(context)!.signIn}",
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
}
