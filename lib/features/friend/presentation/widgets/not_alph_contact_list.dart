import 'package:flutter/material.dart';
import 'contact_info_widget.dart';

class NotAlphContactList extends StatelessWidget {
  const NotAlphContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => ContactInfoWidget(username: "Marwan",bio: "Hi i use ChatBox", image: 'https://static.vecteezy.com/system/resources/previews/048/926/084/non_2x/silver-membership-icon-default-avatar-profile-icon-membership-icon-social-media-user-image-illustration-vector.jpg',),
      itemCount:4,
      separatorBuilder: (context, index) => SizedBox(height: 5,),

    );
  }
}
