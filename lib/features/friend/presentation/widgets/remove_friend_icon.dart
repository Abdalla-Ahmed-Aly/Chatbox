import 'package:chatbox/core/widget/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class RemoveFriendIcon extends StatelessWidget {
  const RemoveFriendIcon({super.key,});


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: (){
          showDialog(context: context, builder: (context) => CustomAlertDialog(actionButtonText: "Remove", title: "Remove Friend", description: "Are you sure", onActionPressed: (){}),);

        },
        child:SvgPicture.asset(
          "assets/svg/removeFriend.svg",
          width:26,
          height: 26,
        )
      ),
    );
  }
}
