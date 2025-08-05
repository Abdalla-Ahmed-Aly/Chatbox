
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/apptheme.dart';

class Customebutton extends StatelessWidget {
  String text;
  Color? textColor;
  Color? buttonColor;

  void Function() onPressed;
  Customebutton({required this.onPressed, required this.text, this.textColor,this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed:onPressed,
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(color: textColor),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: EdgeInsets.all(16),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
