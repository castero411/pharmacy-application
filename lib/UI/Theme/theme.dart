import 'package:flutter/material.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';

var lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: xScaffoldColorLight,
  indicatorColor: xLightTextColor,
  appBarTheme: AppBarTheme(
    backgroundColor: xScaffoldColorLight,
    titleTextStyle: bigTextStyle,
  ),
  hintColor: xHintColor,
  iconTheme: IconThemeData(color: xLightTextColor),
  primaryColor: xMainColor,
  buttonTheme: ButtonThemeData(buttonColor: xMainColor),
  textTheme: TextTheme(
    titleLarge: bigTextStyle,
    bodyLarge: veryBigTextStyle,
    bodySmall: smallTextStyle,
    labelMedium: smallTextStyle,
    labelLarge: labelTextStyle,
    headlineMedium: mediumTextStyle,
  ),
  colorScheme: ColorScheme.light().copyWith(
      primary: xMainColor,
      onPrimary: xScaffoldColorLight,
      secondary: xSecondaryColor,
      onSecondary: xSecondaryColor.withOpacity(.3),
      primaryContainer: xMainColor.withAlpha(10)),
);

var darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark().copyWith(
      primary: xMainColorDark,
    ),
    primaryColor: xMainColorDark);
