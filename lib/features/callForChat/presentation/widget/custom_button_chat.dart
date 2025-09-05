import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButtonChat extends StatelessWidget {
 final IconData? icon;
 final Color? color;
 final Function()? onPressed;
  const CustomButtonChat({super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(40),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppTheme.darkWhite, size: 30),
      ),
    );
  }
}
