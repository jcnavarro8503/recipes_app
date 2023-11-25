import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      smallBody: Container(),
      phoneBody: const PhoneSettingsBody(),
      tabletBody: const TabletSettingsBody(),
      desktopBody: const DesktopSettingsBody(),
    );
  }
}
