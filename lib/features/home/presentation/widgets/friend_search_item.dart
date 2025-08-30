import 'package:chatbox/core/theme/search_delegate_theme.dart';
import 'package:chatbox/features/home/presentation/widgets/app_bar_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FriendSearchItem extends SearchDelegate {

  FriendSearchItem();
  @override
  String get searchFieldLabel =>"Search username";
  @override
  ThemeData appBarTheme(BuildContext context) {
    return SearchDelegateTheme.searchTheme;
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      AppBarIcon(onPressed:searchFunction
        ,icon:CupertinoIcons.search,)
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
    return Scaffold();
  }

  void searchFunction(){
  }
}