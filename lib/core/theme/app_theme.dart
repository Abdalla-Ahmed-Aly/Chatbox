import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Color(0xffFFFFFF);
  static Color red = Color(0xffF04A4C);
  static Color black = Color(0xff000E08);
  static Color gray = Color(0xff797C7B);
  static Color lightGreen = Color(0xff20A090);
  static Color green = Color(0xff24786D);
  static Color whiteGreen = Color(0xffF2F7FB);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: primary,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: lightGreen,
      unselectedItemColor: gray,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 12,
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade400,
          width: 0.7,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade400,
          width: 0.7,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.primary,
          width: 1,
        ),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: primary,
        fontSize: 68,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w700, //bold font
      ),
      displayMedium: TextStyle(
        color: black,
        fontSize: 68,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w500, // medium font
      ),
      displaySmall: TextStyle(
        color: primary,
        fontSize: 40,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w700, // bold font
      ),
      headlineLarge: TextStyle(
        color: primary,
        fontSize: 40,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w500, // medium font
      ),
      headlineMedium: TextStyle(
        color: primary,
        fontSize: 20,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w500, // medium font
      ),
      headlineSmall: TextStyle(
        color: primary,
        fontSize: 18,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w700, // bold font
      ),
      titleLarge: TextStyle(
        color: primary,
        fontSize: 16,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w700, // bold font
      ),
      titleMedium: TextStyle(
        color: primary,
        fontSize: 16,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w500, // medium font
      ),
      titleSmall: TextStyle(
        color: primary,
        fontSize: 16,
        fontFamily: 'myFonst',
        fontWeight: FontWeight.w400, // regular font
      ),
      bodyLarge: TextStyle(
        color: primary,
        fontSize: 14,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w300, // light font
      ),
      bodyMedium: TextStyle(
        color: primary,
        fontSize: 14,
        fontWeight: FontWeight.w500, // medium font
      ),
      bodySmall: TextStyle(
        color: primary,
        fontSize: 12,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w300, // light font
      ),
      labelLarge: TextStyle(
        color: primary,
        fontSize: 14,
        fontFamily: 'myFonts',
        fontWeight: FontWeight.w400, // regular font
      ),
    ),
  );
}
