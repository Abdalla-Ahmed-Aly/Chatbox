import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RingIcon extends StatelessWidget {
  const RingIcon({super.key,required this.title,required this.iconPath,required this.onPress});
final String iconPath;
final String title;
final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          SvgPicture.asset("assets/svg/$iconPath.svg"),
          const SizedBox(
            height:10 ,
          ),
          Text(title,style:Theme.of(context).textTheme.titleMedium,)


        ],

      ),
    );
  }
}
