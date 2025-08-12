import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);

    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppTheme.darkWhite,

      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        hintStyle: TextStyle(color: AppTheme.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.darkWhite, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.darkWhite, width: 1),
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: AppTheme.black, fontSize: 16, fontWeight: FontWeight.w500,fontFamily: "myFonts"),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
     IconButton(
       icon:Icon(CupertinoIcons.clear) ,
       onPressed: (){
         query="";


       },

   )
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(CupertinoIcons.back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
return Scaffold(


);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
 return Scaffold();
  }
  
}