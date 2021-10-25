import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  final bool crop;
  final BuildContext loadingContext;

  const ImageSourceBottomSheet(
      {Key? key, required this.crop, required this.loadingContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(Helper.normalPadding),
              child: Text(
                'Source',
                style: AppTheme.headline3.bold,
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(CupertinoIcons.camera_fill),
              title: const Text(
                'Camera',
                style: AppTheme.text1,
              ),
              onTap: () async {
                context.loaderOverlay.show();
                final res = await Helper.pickImage(
                    source: ImageSource.camera, crop: crop, context: context);
                context.loaderOverlay.hide();
                Navigator.pop(context, res);
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.photo),
              title: const Text(
                'Gallery',
                style: AppTheme.text1,
              ),
              onTap: () async {
                context.loaderOverlay.show();
                final res = await Helper.pickImage(
                    source: ImageSource.gallery, crop: crop, context: context);
                context.loaderOverlay.hide();
                Navigator.pop(context, res);
              },
            ),
          ],
        ),
      ),
    );
  }
}
