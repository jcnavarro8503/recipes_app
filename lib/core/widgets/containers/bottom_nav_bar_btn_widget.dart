import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_app/core/index.dart';

class BottomNavBarBtnWidget extends StatelessWidget {
  final String path;
  final String assetName;
  final String label;
  final bool active;
  final OnPressed? onPressed;

  const BottomNavBarBtnWidget({
    super.key,
    this.path = 'icons',
    required this.assetName,
    required this.label,
    this.active = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: onPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'assets/$path/${assetName}_${getThemeName(state.theme)}${active ? '_active' : ''}.svg'),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: getTextColorByThemeName(state.theme, active),
                    fontFamily: 'Nunito',
                  ),
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
