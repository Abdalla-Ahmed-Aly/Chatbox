import 'package:flutter/material.dart';
import '../../domain/entity/friend_entity.dart';
import 'contact_info_widget.dart';

class NotAlphContactList extends StatelessWidget {
  const NotAlphContactList({super.key,required this.friends});
  final List<FriendEntity>friends;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => ContactInfoWidget(username: friends[index].username,bio:friends[index].bio , image: friends[index].profilePic,isNeedToLeading: false,),
      itemCount:friends.length,
      separatorBuilder: (context, index) => SizedBox(height: 5,),

    );
  }
}
