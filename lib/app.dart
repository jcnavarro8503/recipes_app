import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipes_app/core/index.dart';

class RecipesApp extends StatefulWidget {
  const RecipesApp({Key? key}) : super(key: key);

  @override
  RecipesAppState createState() => RecipesAppState();
}

class RecipesAppState extends State<RecipesApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return BlocBuilder<LocalizationBloc, LocalizationState>(builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Recipes',
          theme: getIt<ThemeBloc>().state.themeData,
          routerConfig: router,
          locale: getIt<LocalizationBloc>().state.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      });
    });
  }
}
