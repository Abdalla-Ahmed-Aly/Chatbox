import 'package:chatbox/core/theme/search_delegate_theme.dart';
import 'package:chatbox/features/friend/presentation/cubit/friend_cubit/friend_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/friend_entity.dart';
import 'app_bar_icon.dart';
import 'contact_list.dart';

class SearchItem extends SearchDelegate {


 SearchItem();
  @override
  String get searchFieldLabel =>'Find your friend';
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
    final List<FriendEntity>friends = context.read<FriendCubit>().friendsList;
    final List<FriendEntity>searchedFriends =query.isEmpty?[]: friends.where((friend)=>friend.username.toLowerCase().contains(query.toLowerCase())).toList();

    return ContactList(header: 'Results',isAlph: false,friends: searchedFriends,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<FriendEntity>friends = context.read<FriendCubit>().friendsList;
    final List<FriendEntity>searchedFriends = query.isEmpty
        ? []
        : friends
        .where((item) => item.username.toLowerCase().contains(query.toLowerCase()))
        .toList();

 return ContactList(header: 'Results',isAlph: false,friends: searchedFriends,);
  }
  void clearFunction(){
    query="";
}

}