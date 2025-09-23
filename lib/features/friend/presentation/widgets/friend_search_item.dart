import 'package:chatbox/core/theme/search_delegate_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_friend/result_list.dart';
import 'app_bar_icon.dart';


class FriendSearchItem extends SearchDelegate {

  FriendSearchItem();

  @override
  String get searchFieldLabel => "Add friend with his username";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return SearchDelegateTheme.searchTheme;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
   AppBarIcon(icon:CupertinoIcons.search ,onPressed: (){},)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return AppBarIcon(onPressed: () {
      close(context, null);
    }, icon: CupertinoIcons.back,);
  }

  @override
  Widget buildResults(BuildContext context) {
    return ResultList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold();
  }


}