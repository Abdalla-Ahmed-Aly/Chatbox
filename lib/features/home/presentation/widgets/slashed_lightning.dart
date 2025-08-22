import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SlashedLightning extends StatelessWidget {
  const SlashedLightning({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FaIcon(FontAwesomeIcons.bolt, size: 30, color: AppTheme.primary),
        Transform.rotate(
          angle: 0.25,
          child: FaIcon(
            FontAwesomeIcons.slash,
            size: 30,
            color: AppTheme.primary,
          ),
        ),
      ],
    );
  }
}
