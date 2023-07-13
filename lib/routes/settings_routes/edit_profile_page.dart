import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '/utils/theming.dart';
import '/widgets/edit_field.dart';
import '/widgets/custom_floating_button.dart';
import '/widgets/dialogs/account_delete_confirm.dart';
import '/widgets/dialogs/image_picker_sheet.dart';
import '/controllers/user_controller.dart';
import '/models/user.dart';
import '/widgets/dialogs/success_sheet.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late int? selectedFieldIndex;

  late List<int> errorFields;

  XFile? pfp;
  late final TextEditingController firstNameCtrl;
  late final TextEditingController lastNameCtrl;

  //Display ONLY (don't use for sending HTTP request)
  late final TextEditingController birthdayCtrl;
  DateTime? dateOfBirth; //Use this in HTTP request
  late final TextEditingController passwordCtrl;

  @override
  void initState() {
    super.initState();
    errorFields = [];
    firstNameCtrl = TextEditingController();
    lastNameCtrl = TextEditingController();
    birthdayCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    selectedFieldIndex = null;
    initializeDateFormatting();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    birthdayCtrl.dispose();
    passwordCtrl.dispose();
  }

  void _onFieldSelect(int index) {
    setState(() => selectedFieldIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      floatingActionButton: CustomFloatingButton(
        caption: AppLocalizations.of(context)!.save,
        onTap: () async {
          errorFields = [];
          final allFields = <String>[
            ".",
            ".",
            birthdayCtrl.text,
            passwordCtrl.text,
          ];
          final tempErrorList = <int>[];
          for (int i = 0; i < allFields.length; i++) {
            if (allFields[i].isEmpty) tempErrorList.add(i);
          }
          setState(() => errorFields = tempErrorList);
          if (errorFields.isNotEmpty) return;
          final success = await UserController.updateMe(
            User(
              firstName: firstNameCtrl.text,
              lastName: lastNameCtrl.text,
              dateOfBirth: dateOfBirth,
              password: passwordCtrl.text,
              pfp: pfp?.path,
            ),
          );
          if (!mounted) return;
          showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return SuccessSheet(
                success: success,
                successMsg: AppLocalizations.of(context)!.updatedSuccess,
                failureMsg: AppLocalizations.of(context)!.updatedFailure,
              );
            },
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theming.bgColor,
            pinned: true,
            surfaceTintColor: Theming.bgColor,
            shadowColor: Theming.bgColor,
            title: Text(
              AppLocalizations.of(context)!.editProfilePage,
              style: const TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Theming.bgColor,
                      builder: (ctx) => const AccountDeleteConfirm(),
                    );
                  },
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Theming.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 20,
              ),
              child: Column(
                children: [
                  GestureDetector(
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
                        //I have no idea why I couldn't do image stuff in one line :(
                        pfp == null
                            ? const CircleAvatar(
                                radius: 45,
                                backgroundColor: Theming.bgColorLight,
                                backgroundImage: AssetImage(
                                  "assets/images/default_pfp.png",
                                ),
                              )
                            : CircleAvatar(
                                radius: 45,
                                backgroundColor: Theming.bgColorLight,
                                backgroundImage: FileImage(File(pfp!.path)),
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
                  const SizedBox(height: 10),
                  EditField(
                    index: 0,
                    caption: AppLocalizations.of(context)!.firstName,
                    icon: Icons.sentiment_satisfied_rounded,
                    placeholder: AppLocalizations.of(context)!.firstName,
                    ctrl: firstNameCtrl,
                    onSelect: (idx) => _onFieldSelect(idx),
                    selectedFieldIndex: selectedFieldIndex,
                    errorFields: errorFields,
                  ),
                  EditField(
                    index: 1,
                    caption: AppLocalizations.of(context)!.lastName,
                    icon: Icons.contact_emergency_rounded,
                    placeholder: AppLocalizations.of(context)!.lastNameField,
                    ctrl: lastNameCtrl,
                    onSelect: (idx) => _onFieldSelect(idx),
                    selectedFieldIndex: selectedFieldIndex,
                    errorFields: errorFields,
                  ),
                  EditField(
                    index: 2,
                    caption: AppLocalizations.of(context)!.dateOfBirth,
                    icon: Icons.calendar_month_rounded,
                    isDate: true,
                    ctrl: birthdayCtrl,
                    isDateSelected: birthdayCtrl.text.isNotEmpty,
                    placeholder: AppLocalizations.of(context)!.dateOfBirth,
                    keyboardType: TextInputType.none,
                    selectedFieldIndex: selectedFieldIndex,
                    errorFields: errorFields,
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
                      dateOfBirth = datePickerVal;
                    },
                  ),
                  EditField(
                    index: 3,
                    caption: AppLocalizations.of(context)!.password,
                    icon: Icons.password,
                    placeholder: AppLocalizations.of(context)!.passwordField,
                    ctrl: passwordCtrl,
                    selectedFieldIndex: selectedFieldIndex,
                    onSelect: (idx) => _onFieldSelect(idx),
                    isPassword: true,
                    errorFields: errorFields,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
