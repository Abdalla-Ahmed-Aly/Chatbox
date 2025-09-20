import 'package:chatbox/core/theme/search_delegate_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_bar_icon.dart';
import 'contact_list.dart';

class SearchItem extends SearchDelegate {

 SearchItem();
  @override
  String get searchFieldLabel =>'Search username ';
  @override
  ThemeData appBarTheme(BuildContext context) {
    return SearchDelegateTheme.searchTheme;
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
 AppBarIcon(onPressed: clearFunction
   ,icon:CupertinoIcons.clear,)
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
 return ContactList(header: 'Chat',isAlph: false, friends: [],);
  }
  void clearFunction(){
    query="";
}

}