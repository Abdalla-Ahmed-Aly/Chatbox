import 'package:chatbox/core/widget/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class RemoveFriendIcon extends StatelessWidget {
  const RemoveFriendIcon({super.key,required this.userName});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: (){
          showDialog(context: context, builder: (context) => CustomAlertDialog(actionButtonText: "Remove Friend", title: "Remove Friend ", description: "Are you sure about removing $userName ", onActionPressed: (){}),);

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
