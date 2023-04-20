import 'package:flutter/material.dart';

import '/utils/theming.dart';
import '/utils/locale_support.dart';

final _descriptionCtrl = TextEditingController();

class DescriptionPage extends StatelessWidget {
  //description, index
  final Function(TextEditingController, int) onNext;

  //index
  final Function(int) onPrevious;

  const DescriptionPage({
    required this.onPrevious,
    required this.onNext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);

    const double topLeftRightPadding = 15;

    return Scaffold(
      backgroundColor: Theming.bgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          transl.createAParty,
          style: const TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theming.bgColor,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 30,
              right: 30,
              bottom: 150,
            ),
            child: TextField(
              maxLines: null,
              style: const TextStyle(color: Theming.whiteTone),
              cursorColor: Theming.primaryColor,
              decoration: InputDecoration(
                hintText: transl.descOptional,
                hintStyle: TextStyle(
                  color: Theming.whiteTone.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              controller: _descriptionCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _categoryText(transl.description),
                      TextButton(
                        onPressed: () => _descriptionCtrl.clear(),
                        child: Text(
                          transl.clear,
                          style: Styles.smallTextButton,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 160,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Theming.bgColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Theming.bgColor,
                    offset: Offset(0, -20),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 80,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navButton(
                    context,
                    topLeftRightPadding,
                    backgroundColor: Theming.whiteTone,
                    text: Text(
                      transl.back,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () => onPrevious(0),
                  ),
                  _navButton(
                    context,
                    topLeftRightPadding,
                    backgroundColor: Theming.primaryColor,
                    text: Text(
                      transl.next,
                      style: const TextStyle(
                        color: Theming.whiteTone,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () => onNext(_descriptionCtrl, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryText(String caption) {
    return Text(
      caption,
      style: const TextStyle(
        color: Theming.whiteTone,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget _navButton(
    BuildContext ctx,
    double padding, {
    required Color backgroundColor,
    required Text text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: (MediaQuery.of(ctx).size.width - padding * 2) / 2 - 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: text,
      ),
    );
  }
}
