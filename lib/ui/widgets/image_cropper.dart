import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
// import 'package:xetia_shop/xetia_shop.dart';

class ImageCropper extends StatefulWidget {
  final String imagePath;

  const ImageCropper({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  _ImageCropperState createState() => _ImageCropperState();
}

class _ImageCropperState extends State<ImageCropper> {
  Uint8List? image;
  final controller = CropController();
  int index = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final file = File(widget.imagePath);
    if (await file.exists()) {
      image = await file.readAsBytes();
      setState(() {});
    }
  }

  Completer<File>? _completer;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: _buildBody(),
          bottomNavigationBar: Material(
            type: MaterialType.card,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: Helper.smallPadding,
                ),
                height: 72,
                child: Row(
                  children: [
                    TextButton(
                      child: Text(
                        'FREE',
                        style: index == 0
                            ? AppTheme.text1.purple.bold
                            : AppTheme.text1.purple,
                      ),
                      onPressed: () {
                        controller.aspectRatio = null;
                        setState(() => index = 0);
                      },
                    ),
                    TextButton(
                      child: Text(
                        '1:1',
                        style: index == 1
                            ? AppTheme.text1.purple.bold
                            : AppTheme.text1.purple,
                      ),
                      onPressed: () {
                        controller.aspectRatio = 1;
                        setState(() => index = 1);
                      },
                    ),
                    TextButton(
                      child: Text(
                        '16:9',
                        style: index == 2
                            ? AppTheme.text1.purple.bold
                            : AppTheme.text1.purple,
                      ),
                      onPressed: () {
                        controller.aspectRatio = 16 / 9;
                        setState(() => index = 2);
                      },
                    ),
                    TextButton(
                      child: Text(
                        '4:3',
                        style: index == 3
                            ? AppTheme.text1.purple.bold
                            : AppTheme.text1.purple,
                      ),
                      onPressed: () {
                        controller.aspectRatio = 4 / 3;
                        setState(() => index = 3);
                      },
                    ),
                    Flexible(
                      child: CustomButton(
                        isLoading: isLoading,
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          _completer = Completer();

                          controller.crop();
                          final result = await _completer!.future;
                          Navigator.pop(context, result);
                        },
                        text: 'CROP',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    if (image == null) {
      return Center(child: CircularLoading());
    }

    return Crop(
      image: image!,
      controller: controller,
      baseColor: Colors.black,
      maskColor: Colors.black54,
      cornerDotBuilder: (size, edgeAlignment) {
        return SizedBox(
          width: size,
          height: size,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.purple,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
      onCropped: (value) async {
        var src = img.decodeImage(value)!;
        if (src.width >= 1080 || src.height >= 1080) {
          if (src.width >= src.height) {
            src = img.copyResize(src, width: 1080);
          } else {
            src = img.copyResize(src, height: 1080);
          }
        }

        final bytes = img.encodeJpg(src);
        final tmpDir = await getTemporaryDirectory();
        final name = DateTime.now().microsecondsSinceEpoch.toString() + '.jpg';
        final result = File(tmpDir.absolute.path + '/' + name);
        await result.writeAsBytes(bytes, flush: true);
        setState(() {
          isLoading = false;
        });
        _completer?.complete(result);
      },
    );
  }
}
