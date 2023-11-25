import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget smallBody;
  final Widget phoneBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.smallBody,
    required this.phoneBody,
    required this.tabletBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < smallDevices) {
          return smallBody;
        } else if (constraints.maxWidth < phoneDevices) {
          return phoneBody;
        } else if (constraints.maxWidth < tabletDevices) {
          return tabletBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
