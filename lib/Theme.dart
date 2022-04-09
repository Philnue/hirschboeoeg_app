import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static const darkThemeCupertino = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.white,
    primaryContrastingColor: CupertinoColors.black,
    barBackgroundColor: CupertinoColors.black,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.white,
    ),
  );

  static const lightThemeCupertino = CupertinoThemeData(
    brightness: Brightness.light,
    barBackgroundColor: CupertinoColors.white,
    primaryColor: CupertinoColors.black,
    primaryContrastingColor: CupertinoColors.black,

    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.black,
      textStyle: TextStyle(
        color: CupertinoColors.black,
        fontSize: 18,
      ),
    ),

    //! algemeines text style theme in text theme
  );

  static final lightThemeAndroid = ThemeData(
    colorScheme: const ColorScheme.light(),
    primaryColor: Colors.black,
    backgroundColor: Colors.brown,
  );

  static final darkThemeAndroid = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );
}
