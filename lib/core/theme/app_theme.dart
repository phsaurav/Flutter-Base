import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_theme.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  // primaryColor: colorPrimary,
  // primarySwatch: Colors.blue,
  primaryColorLight: colorPrimaryLight,
  canvasColor: colorBg,

  textTheme: appTextTheme,
  // scaffoldBackgroundColor: colorBg,
  // useMaterial3: true,
  colorSchemeSeed: colorPrimary,
  // colorScheme: ColorScheme(
  //   primary: colorPrimary, // <---- I set white color here
  //   secondary: colorSecondary,
  //   background: colorBg,
  //   surface: colorBg,
  //   onBackground: Colors.white,
  //   error: colorError,
  //   onError: colorSecondaryDark,
  //   onPrimary: colorOnPrimary,
  //   onSecondary: colorOnSecondary,
  //   onSurface: Color(0xFF241E30),
  //   brightness: Brightness.light,
  // ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
);
