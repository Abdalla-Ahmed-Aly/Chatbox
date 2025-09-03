import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ShrinkTextField extends StatefulWidget {
  void Function(PointerDownEvent) onTapOustSide;
  void Function(PointerUpEvent) onTapUpOustSide;
  final TextEditingController textController;
  final TextAlign textAlign;
  Color color;
  Color backGroundColor;
  double fontSize;
  final double? maxWidth;

  ShrinkTextField({
    super.key,
    required this.textController,
    required this.color,
    required this.fontSize,
    required this.onTapOustSide,
    required this.onTapUpOustSide,
    required this.textAlign,
    required this.backGroundColor,
    this.maxWidth,
  });

  @override
  _ShrinkTextFieldState createState() => _ShrinkTextFieldState();
}

class _ShrinkTextFieldState extends State<ShrinkTextField> {
  double textWidth = 60;
  double textHeight = 40;
  int? maxLines = 1;

  void _updateDimensions() {
    final text = widget.textController.text.isEmpty
        ? " "
        : widget.textController.text;

    //
    final singleLineTextPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      maxLines: 1,
      textAlign: widget.textAlign,
      textDirection: TextDirection.ltr,
    )..layout();

    double calculatedWidth = singleLineTextPainter.width + 40;
    double maxAllowedWidth = widget.maxWidth ?? double.infinity;

    if (calculatedWidth <= maxAllowedWidth) {
      setState(() {
        textWidth = calculatedWidth;
        textHeight = singleLineTextPainter.height + 16;
        maxLines = 1;
      });
    } else {
      final multiLineTextPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        maxLines: null,
        textAlign: widget.textAlign,
        textDirection: TextDirection.ltr,
      )..layout(minWidth: 0, maxWidth: maxAllowedWidth - 40);

      setState(() {
        textWidth = maxAllowedWidth;
        textHeight = multiLineTextPainter.height + 16;
        maxLines = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_updateDimensions);
    _updateDimensions();
  }

  @override
  void dispose() {
    widget.textController.removeListener(_updateDimensions);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: textWidth,
      // height: textHeight,
      decoration: BoxDecoration(
        color: widget.backGroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: widget.textController,
        autofocus: true,
        onTapOutside: (event) {
          widget.onTapOustSide(event);
        },
        onTapUpOutside: (event) {
          widget.onTapUpOustSide(event);
        },
        cursorColor: AppTheme.primary,
        textAlign: widget.textAlign,
        style: TextStyle(
          color: widget.color,
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: const Offset(1, 1),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          isDense: true,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
