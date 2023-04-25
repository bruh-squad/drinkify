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
    final double bottomNavHeight = 100 + MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Theming.bgColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 60,
              left: 30,
              right: 30,
              bottom: bottomNavHeight + 10,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theming.whiteTone.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                maxLines: null,
                style: const TextStyle(color: Theming.whiteTone),
                cursorColor: Theming.primaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: transl.descOptional,
                  hintStyle: TextStyle(
                    color: Theming.whiteTone.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                controller: _descriptionCtrl,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 10,
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
              height: bottomNavHeight,
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                color: Theming.bgColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Theming.bgColor,
                    offset: Offset(0, -15),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                top: 10,
                left: 30,
                right: 30,
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
