import 'package:flutter/material.dart';

import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

class MyRecipesPage extends StatelessWidget {
  const MyRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      smallBody: Container(),
      phoneBody: const PhoneMyRecipesBody(),
      tabletBody: const TabletMyRecipesBody(),
      desktopBody: const DesktopMyRecipesBody(),
    );
  }
}
