import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class RequestIcon extends StatelessWidget {
  const RequestIcon({super.key,required this.userName,required this.onTap,required this.iconPath});
  final String userName;
  final VoidCallback onTap;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
          onTap: onTap,
          child:SvgPicture.asset(
            "assets/svg/$iconPath.svg",
            width:27,
            height: 27,
          )
      ),
    );
  }
}