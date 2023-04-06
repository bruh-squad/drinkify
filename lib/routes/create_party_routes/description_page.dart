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

    const double topLeftRightPadding = 25;

    return Stack(
      children: [
        Dialog(
          backgroundColor: Theming.bgColor,
          insetPadding: const EdgeInsets.only(
            left: topLeftRightPadding,
            right: topLeftRightPadding,
            top: topLeftRightPadding,
            bottom: 130,
          ),
          insetAnimationDuration: const Duration(days: 360),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
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
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: _categoryText(transl.createAParty),
                        ),
                        const SizedBox(height: 30),
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
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 40,
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
        height: 70,
        width: (MediaQuery.of(ctx).size.width - padding * 2) / 2 - 10,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: text,
      ),
    );
  }
}
