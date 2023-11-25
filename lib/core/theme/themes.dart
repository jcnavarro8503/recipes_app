import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:recipes_app/core/index.dart';

enum Themes { light, dark }

final themesData = {
  ///--------------------------------------- Light Theme
  Themes.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    // textTheme: GoogleFonts.workSansTextTheme(),
    scaffoldBackgroundColor: lightBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackgroundColor,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: lightTextColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightBackgroundContrastColor,
      unselectedItemColor: lightBackgroundContrastColor,
      selectedItemColor: lightBackgroundColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightPrimaryColor,
      splashColor: lightSecondaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 20,
            overflow: TextOverflow.fade,
          ),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(lightPrimaryColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: lightBackgroundContrastColor,
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(lightSecondaryColor),
      thumbColor: MaterialStateProperty.all<Color>(lightPrimaryColor),
    ),
  ),

  ///--------------------------------------- Dark Theme
  Themes.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    shadowColor: darkShadowColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackgroundColor,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: darkTextColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkBackgroundContrastColor,
      unselectedItemColor: darkTextColor,
      selectedItemColor: darkTextContrastColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: darkBackgroundColor,
      splashColor: darkBackgroundContrastColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 20,
            overflow: TextOverflow.fade,
          ),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(darkPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        overlayColor: MaterialStateProperty.all<Color>(Colors.black26),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: darkBackgroundContrastColor,
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(darkBackgroundContrastColor),
      thumbColor: MaterialStateProperty.all<Color>(darkBackgroundColor),
    ),
  ),
};

String getThemeName(Themes theme) {
  return theme.toString().replaceAll('Themes.', '');
}

Color getTextColorByThemeName(Themes theme, bool active) {
  String name = getThemeName(theme);
  switch (name) {
    case 'dark':
      return active ? darkTextContrastColor : darkTextColor;
    default: // light
      return active ? lightTextContrastColor : lightTextColor;
  }
}

Color getBackgroundColorByThemeName(Themes theme, bool active) {
  String name = getThemeName(theme);
  switch (name) {
    case 'dark':
      return active ? darkPrimaryColor : darkBackgroundContrastColor;
    default: // light
      return active ? lightPrimaryColor : lightBackgroundContrastColor;
  }
}
