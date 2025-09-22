import 'package:chatbox/features/friend/domain/entity/friend_request_entity.dart';
import 'package:chatbox/features/friend/presentation/widgets/friend_request/request_content.dart';
import 'package:flutter/material.dart';

class RequestList extends StatelessWidget {
  const RequestList({super.key,required this.friendRequestList});
  final List<FriendRequestEntity> friendRequestList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => RequestContent( image: friendRequestList[index].profilePic,
      bio: friendRequestList[index].bio,
      username: friendRequestList[index].username,),
    itemCount: friendRequestList.length,

    );
  }
}
