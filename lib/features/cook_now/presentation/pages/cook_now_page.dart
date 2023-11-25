import 'package:flutter/material.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class CookNowPage extends StatelessWidget {
  const CookNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      smallBody: Container(),
      phoneBody: const PhoneCookNowBody(),
      tabletBody: const TabletCookNowBody(),
      desktopBody: const DesktopCookNowBody(),
    );
  }
}
