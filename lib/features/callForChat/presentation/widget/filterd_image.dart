import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

class FilterImage extends StatelessWidget {
  const FilterImage({super.key});

  @override
  Widget build(BuildContext context) {
    return   ImageFiltered(
      imageFilter:  ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Image.asset(
        'assets/images/photoChat.png',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
