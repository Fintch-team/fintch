import 'dart:io';

import 'package:fintch/gen_export.dart';
import 'package:fintch/ui/widgets/image_cropper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<File?> getImage(
    {bool withCrop = true, required BuildContext context}) async {
  final res = await showCupertinoModalBottomSheet(
    context: context,
    expand: false,
    enableDrag: true,
    isDismissible: true,
    topRadius: Radius.circular(20),
    backgroundColor: AppTheme.white,
    barrierColor: AppTheme.black.withOpacity(0.2),
    builder: (builderContext) => ImageSourceDialog(
      crop: withCrop,
      loadingContext: context,
    ),
  );

  if (res != null) {
    return res as File;
  }

  return null;
}

Future<File?> pickImage({
  required ImageSource source,
  required bool crop,
  required BuildContext context,
}) async {
  try {
    final picked = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 50,
    );
    if (picked == null) return null;
    if (crop) {
      return cropImage(path: picked.path, context: context);
    }

    return File(picked.path);
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}

Future<File?> cropImage({
  required String path,
  required BuildContext context,
}) async {
  final res = await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ImageCropper(
              imagePath: path,
            )),
  );
  // final res = await showFullscreenDialog(
  //   builder: (context) => ImageCropper(
  //     imagePath: path,
  //   ),
  // );

  if (res is File) {
    return res;
  }

  return null;
}

class ImageSourceDialog extends StatelessWidget {
  final bool crop;
  final BuildContext loadingContext;

  const ImageSourceDialog(
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
                final res = await pickImage(
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
                final res = await pickImage(
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
