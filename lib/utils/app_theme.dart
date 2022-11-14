import 'package:google_fonts/google_fonts.dart';

import '../constants/color_constants.dart';
import 'package:flutter/material.dart';

class Themes {
  static final appTheme = ThemeData(
    primaryColor: AppColors.burgundy,
    scaffoldBackgroundColor: AppColors.lightGrey,
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.orangeWeb),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.burgundy),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.orangeWeb),
  );

  static final darkTheme = ThemeData(
      // scaffoldBackgroundColor: Colors.,
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
      cardColor: AppColors.lightGrey,
      errorColor: AppColors.lightGrey,
      primaryColor: AppColors.lightGrey,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black26),
      textTheme: GoogleFonts.poppinsTextTheme()
          .apply(bodyColor: Colors.white)
          .copyWith(subtitle1: TextStyle(color: Colors.black)),
      canvasColor: Colors.grey[800],
      hintColor: Colors.black);
}
