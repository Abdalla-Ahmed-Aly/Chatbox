import 'package:chatbox/features/friend/presentation/widgets/add_friend/result_content.dart';
import 'package:flutter/material.dart';

class ResultList extends StatelessWidget {
  const ResultList({super.key,});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => ResultContent( image: "https://static.vecteezy.com/system/resources/thumbnails/048/926/084/small_2x/silver-membership-icon-default-avatar-profile-icon-membership-icon-social-media-user-image-illustration-vector.jpg",
      bio:"Hi,I'm here",
      username: "Marwan",),
      itemCount: 5,

    );
  }
}
