import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';

class IconDataWidget extends StatelessWidget {
  final String path;
  final String assetName;
  final double? width;
  final double? height;
  final String text;
  final String sufix;

  const IconDataWidget({
    super.key,
    this.path = 'icons',
    required this.assetName,
    this.width,
    this.height,
    required this.text,
    required this.sufix,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ThemeSvgWidget(
          path: path,
          assetName: assetName,
          height: height,
          width: width,
        ),
        const SizedBox(width: 5),
        Text(
          '$text $sufix',
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }
}
