import 'package:flutter/material.dart';
import 'package:chatbox/core/widget/OnlineAvatar.dart';

class Continercusomeresiver extends StatelessWidget {
  final String imagePath;
  final bool isOnline;
  final double radius;
  final Widget messageContent;

  const Continercusomeresiver({
    required this.imagePath,
    required this.isOnline,
    this.radius = 20,
    required this.messageContent,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnlineAvatar(
            imagePath: imagePath,
            isOnline: isOnline,
            radius: radius,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: messageContent,
            ),
          ),
        ],
      ),
    );
  }
}
