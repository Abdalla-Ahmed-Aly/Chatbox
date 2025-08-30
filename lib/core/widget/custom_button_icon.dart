import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/app_theme.dart';

class CustomButtonIcon extends StatelessWidget {
 final void Function() onTap;
 final String assetName;
  const CustomButtonIcon({super.key, required this.assetName,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){

      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.whiteGreen, width: 1),
          shape: BoxShape.circle,
        ),

        child: SvgPicture.asset(
          'assets/icons/$assetName.svg',
          height: 30,
          width: 24,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
