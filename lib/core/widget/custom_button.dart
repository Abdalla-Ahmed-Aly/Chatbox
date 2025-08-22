import 'package:flutter/material.dart';


class CustomButton extends StatefulWidget {
  String text;
  Color? textColor;
  Color? buttonColor;
  Color? textColorWhenHover;
  Color? buttonColorWhenHover;
  void Function() onPressed;
  CustomButton({super.key, required this.onPressed, required this.text, this.textColor,this.buttonColor,this.buttonColorWhenHover,this.textColorWhenHover});
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHoverd = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed:widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            padding: EdgeInsets.all(16),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            widget.text,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(color: widget.textColor),
          ),
        ),
      ),
    );

  }
}
