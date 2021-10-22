import 'dart:io';

import 'package:fintch/ui/widgets/image_cropper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> getImage(
    {bool withCrop = true, required BuildContext context}) async {
  final res = await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => ImageSourceDialog(
      crop: withCrop,
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
  const ImageSourceDialog({Key? key, required this.crop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Source',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(CupertinoIcons.camera_fill),
              title: const Text('Camera'),
              onTap: () async {
                final res = await pickImage(
                    source: ImageSource.camera, crop: crop, context: context);
                Navigator.pop(context, res);
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                final res = await pickImage(
                    source: ImageSource.gallery, crop: crop, context: context);
                Navigator.pop(context, res);
              },
            ),
          ],
        ),
      ),
    );
  }
}
