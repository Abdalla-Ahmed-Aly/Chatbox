import 'package:chatbox/core/route/route_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FriendRequestButton extends StatelessWidget {
  const FriendRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      context.push(RouteCenter.friendRequestScreen);
    },
      child:Icon(CupertinoIcons.person_add),
    );
  }
}
