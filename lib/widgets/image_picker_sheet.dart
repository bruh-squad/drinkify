import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/theming.dart';

class ImagePickerSheet extends StatelessWidget {
  final Function(XFile) onFinish;
  const ImagePickerSheet({
    required this.onFinish,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Wrap(
          children: [
            _imageOption(context, ImageSource.gallery),
            _imageOption(context, ImageSource.camera),
          ],
        ),
      ),
    );
  }

  Widget _imageOption(BuildContext ctx, ImageSource source) {
    return GestureDetector(
      onTap: () async {
        final imgPicker = ImagePicker();
        final img = await imgPicker.pickImage(source: source);
        if (img != null) {
          onFinish(img);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theming.primaryColor.withOpacity(0.2),
              ),
              child: Icon(
                source == ImageSource.camera ? Icons.photo_camera : Icons.photo_library,
                color: Theming.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              source == ImageSource.gallery
                  ? AppLocalizations.of(ctx)!.imgFromGallery
                  : AppLocalizations.of(ctx)!.takeAPhoto,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
