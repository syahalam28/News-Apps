import 'package:google_fonts/google_fonts.dart';

import '../constants/color_constants.dart';
import 'package:flutter/material.dart';

class Themes {
  static final appTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: AppColors.lightGrey,
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.orangeWeb),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.blueAccent),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.orangeWeb),
  );

  static final darkTheme = ThemeData(
      // scaffoldBackgroundColor: Colors.,
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
      cardColor: AppColors.lightGrey,
      errorColor: AppColors.lightGrey,
      primaryColor: Color.fromARGB(255, 57, 67, 86),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black12),
      textTheme: GoogleFonts.poppinsTextTheme()
          .apply(bodyColor: Colors.white)
          .copyWith(subtitle1: TextStyle(color: Colors.white)),
      canvasColor: Colors.grey[800],
      hintColor: Colors.black);
}
