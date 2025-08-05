import 'package:chatbox/utils/theme/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CustomrbuttonIcons extends StatelessWidget {
  void Function() onTap;
  String assetName;
  CustomrbuttonIcons({required this.assetName,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){

      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.whitegreen, width: 1),
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
