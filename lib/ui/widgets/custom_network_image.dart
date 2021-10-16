import 'package:cached_network_image/cached_network_image.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double borderRadius;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CustomNetworkImage({
    Key? key,
    required this.imgUrl,
    required this.borderRadius,
    this.width,
    this.height,
    this.fit: BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        fit: fit,
        width: width,
        height: height,
        fadeInCurve: Curves.easeInCubic,
        fadeInDuration: Duration(milliseconds: 500),
        fadeOutCurve: Curves.easeOutCubic,
        fadeOutDuration: Duration(milliseconds: 500),
        placeholder: (context, url) => Shimmers(
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.yellow,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey,
          child: Icon(
            Icons.error,
            color: AppTheme.black,
          ),
        ),
      ),
    );
  }
}
