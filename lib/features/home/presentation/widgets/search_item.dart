import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/presentation/widgets/app_bar_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contact_list.dart';

class SearchItem extends SearchDelegate {
 final bool isFriendRequest;
 SearchItem({this.isFriendRequest = false});
  @override
  String get searchFieldLabel =>!isFriendRequest? 'Search username or number':"Search username";
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      textSelectionTheme: TextSelectionThemeData(
cursorColor: AppTheme.black,

      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppTheme.primary,
      ),

      inputDecorationTheme: InputDecorationTheme(

        fillColor: AppTheme.gray.withOpacity(.05),
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
  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
 AppBarIcon(onPressed: isFriendRequest?searchFunction:clearFunction
   ,icon:isFriendRequest?CupertinoIcons.search:CupertinoIcons.clear,)
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return AppBarIcon(onPressed: (){
      close(context, null);

    },icon: CupertinoIcons.back,);
  }

  @override
  Widget buildResults(BuildContext context) {
return Scaffold(


);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
 return !isFriendRequest?  ContactList(header: 'Chat',isAlph: false,):Scaffold();
  }
  void clearFunction(){
    query="";
}
 void searchFunction(){
 }
}