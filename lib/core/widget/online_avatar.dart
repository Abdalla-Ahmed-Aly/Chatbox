import 'package:flutter/material.dart';

class OnlineAvatar extends StatelessWidget {
  final String imagePath;
  final bool isOnline;
  final double radius;
  final VoidCallback? onTap;

  const OnlineAvatar({
    super.key,
    required this.imagePath,
    this.isOnline = true,
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
          if (isOnline)
            Positioned(
              right: -2,
              bottom: -2,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: radius * 0.56,
                height: radius * 0.56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.greenAccent, Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.6),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
