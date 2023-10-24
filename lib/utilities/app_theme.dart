import 'package:chatsy/utilities/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: appBtheme,
      scaffoldBackgroundColor: Constants.bgColor,
      textTheme: TtTheme,
      elevatedButtonTheme: ETheme,
      iconButtonTheme: ITheme,
      inputDecorationTheme: IDTheme);

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBtheme.copyWith(foregroundColor: Colors.black),
      textTheme: TextTheme(
        displayLarge: LText.copyWith(color: Colors.black),
        displayMedium: MText.copyWith(color: Colors.black),
        displaySmall: SText.copyWith(color: Colors.black),
      ),
      elevatedButtonTheme: ETheme,
      iconButtonTheme: ITheme2,
      inputDecorationTheme: IDTheme.copyWith(
        fillColor: Colors.black.withOpacity(.8),
        hintStyle: TextStyle(color: Colors.white.withOpacity(.8)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
        ),
      ));
  static TextStyle LText = const TextStyle(
      fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle MText = const TextStyle(fontSize: 15, color: Colors.white);
  static TextStyle SText = const TextStyle(fontSize: 10, color: Colors.white);
  static ElevatedButtonThemeData ETheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero));
  static ElevatedButtonThemeData ETheme2 = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: EdgeInsets.zero));
  static AppBarTheme appBtheme = const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.white);
  static TextTheme TtTheme =
      TextTheme(displayLarge: LText, displayMedium: MText, displaySmall: SText);
  static IconButtonThemeData ITheme = IconButtonThemeData(
      style: IconButton.styleFrom(backgroundColor: Colors.black));
  static IconButtonThemeData ITheme2 = IconButtonThemeData(
      style: IconButton.styleFrom(backgroundColor: Colors.red));
  static InputDecorationTheme IDTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.black.withOpacity(.25),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black.withOpacity(.25)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    hintStyle: TextStyle(color: Colors.white.withOpacity(.5)),
    prefixIconColor: Colors.white.withOpacity(.5),
    suffixIconColor: Colors.white.withOpacity(.5),
  );
}
