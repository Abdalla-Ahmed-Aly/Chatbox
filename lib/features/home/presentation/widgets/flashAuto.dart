import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlashAutoFA extends StatelessWidget {
  final double size;
  final Color color = AppTheme.primary;

  FlashAutoFA({super.key, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FaIcon(FontAwesomeIcons.bolt, size: size, color: color),
        Positioned(
          bottom: 15,
          right: -1,
          child: Text(
            "A",
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 2,
                  color: Colors.black,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
