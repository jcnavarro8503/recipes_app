import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class InspirationsPage extends StatelessWidget {
  const InspirationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      smallBody: Container(),
      phoneBody: const PhoneInspirationsBody(),
      tabletBody: const TabletInspirationsBody(),
      desktopBody: const DesktopInspirationsBody(),
    );
  }
}
