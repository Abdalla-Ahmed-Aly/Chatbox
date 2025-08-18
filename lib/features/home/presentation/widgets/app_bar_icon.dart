import 'package:flutter/material.dart';


class AppBarIcon extends StatelessWidget {
  const AppBarIcon({super.key,required this.onPressed,required this.icon});

final VoidCallback onPressed;
final IconData icon;
  @override
  Widget build(BuildContext context) {

    return IconButton(
      onPressed: onPressed,
      icon:Icon(icon) ,


    );
  }
}
