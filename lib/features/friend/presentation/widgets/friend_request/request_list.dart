import 'package:chatbox/features/friend/presentation/widgets/friend_request/request_content.dart';
import 'package:flutter/material.dart';

class RequestList extends StatelessWidget {
  const RequestList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => RequestContent( image: "https://static.vecteezy.com/system/resources/previews/048/926/084/non_2x/silver-membership-icon-default-avatar-profile-icon-membership-icon-social-media-user-image-illustration-vector.jpg",
      bio: "Hi i use ChatBox",
      username: "marwan",),
    itemCount: 5,

    );
  }
}
