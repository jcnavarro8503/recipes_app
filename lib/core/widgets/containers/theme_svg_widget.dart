import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_app/core/index.dart';

class ThemeSvgWidget extends StatelessWidget {
  final String path;
  final String assetName;
  final bool active;
  final double? width;
  final double? height;

  const ThemeSvgWidget({
    super.key,
    this.path = 'images',
    required this.assetName,
    this.active = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return SvgPicture.asset(
          'assets/$path/${assetName}_${getThemeName(state.theme)}${active ? '_active' : ''}.svg',
          width: width,
          height: height,
        );
      },
    );
  }
}
