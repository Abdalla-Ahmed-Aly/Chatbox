import 'package:flutter/material.dart';

import 'app_theme.dart';

class SearchDelegateTheme {
 static ThemeData searchTheme=ThemeData(
   textSelectionTheme: TextSelectionThemeData(
     cursorColor: AppTheme.black,

   ),
   appBarTheme: AppBarTheme(
     backgroundColor: AppTheme.primary,
   ),

   inputDecorationTheme: InputDecorationTheme(

     fillColor: AppTheme.gray.withValues(alpha: .05),
     filled: true,

     contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
     hintStyle: TextStyle(color: AppTheme.black),
     enabledBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(12),
       borderSide: BorderSide(color: AppTheme.primary, width: 1),
     ),
     focusedBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(12),
       borderSide: BorderSide(color: AppTheme.primary, width: 1),
     ),
   ),
   textTheme: TextTheme(
     titleLarge: TextStyle(color: AppTheme.black, fontSize: 16, fontWeight: FontWeight.w500,fontFamily: "myFonts"),
   ),

 );




}