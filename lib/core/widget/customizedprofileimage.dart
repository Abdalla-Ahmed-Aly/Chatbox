import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class CircularProfileAvatarWidget extends StatelessWidget {
  final String imagePath;
  final bool isAsset;
  final double radius;
  final Color borderColor;
  final double borderWidth;

  const CircularProfileAvatarWidget({
    super.key,
    required this.imagePath,
    this.isAsset = false,
    this.radius = 60,
    this.borderColor = Colors.white,
    this.borderWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    if (isAsset) {
      return CircularProfileAvatar(
        '',
        borderWidth: borderWidth,
        borderColor: borderColor,
        radius: radius,
        elevation: 8.0,
        child: Transform.translate(
          offset: const Offset(0, -2), // Move up to show head
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: radius * 2.2, // Make it slightly larger
            height: radius * 2.2,
            alignment: Alignment.topCenter, // Focus on top
          ),
        ),
      );
    } else {
      return CircularProfileAvatar(
        imagePath,
        radius: radius,
        borderWidth: borderWidth,
        borderColor: borderColor,
        cacheImage: true,
        // For network images, try different initialOffset
        imageBuilder: (context, imageProvider) => Transform.translate(
          offset: const Offset(0, -20),
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
            width: radius * 2.2,
            height: radius * 2.2,
            alignment: Alignment.topCenter,
          ),
        ),
      );
    }
  }
}
