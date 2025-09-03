import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Avatarforgroub extends StatelessWidget {
  final String imagePath;
  final bool showAddButton;
  final double radius;
  final VoidCallback? onTap;

  const Avatarforgroub({
    super.key,
    required this.imagePath,
    this.showAddButton = true,
    this.radius = 25,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(radius: radius, backgroundImage: AssetImage(imagePath)),
          if (showAddButton)
            Positioned(
              right: 0,
              bottom: 0,
              child: ClipOval(
                child: Container(
                  width: radius * 0.7,
                  height: radius * 0.7,
                  color: Colors.white,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: AppTheme.black,
                      size: radius * 0.6,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
