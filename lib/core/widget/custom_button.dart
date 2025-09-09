import 'package:chatbox/core/widget/loading_indicator.dart';
import 'package:flutter/material.dart';



class CustomButton extends StatefulWidget {
 final String text;
 final Color? textColor;
 final Color? buttonColor;
 final Color? textColorWhenHover;
 final Color? buttonColorWhenHover;
 final void Function() onPressed;
 final bool isLoading;
  const CustomButton({super.key, required this.onPressed, required this.text, this.textColor,this.buttonColor,this.buttonColorWhenHover,this.textColorWhenHover,this.isLoading=false});
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
          child:widget.isLoading?LoadingIndicator(isButton: true,):Text(
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
