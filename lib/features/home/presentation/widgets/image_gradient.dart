import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_color_extractor/flutter_color_extractor.dart';

Future<LinearGradient> getGradientFromImage(File imageFile) async {
  final extractor = ColorExtractor();

  final colors = await extractor.extractColorsFromPath(imageFile.path, k: 4);

  final gradientColors = colors.isNotEmpty
      ? colors.take(3).toList()
      : [Colors.blue, Colors.purple, Colors.red];

  return LinearGradient(
    colors: gradientColors,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class GradientContainer extends StatelessWidget {
  final File imageFile;

  const GradientContainer({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.of(context).size;
    return FutureBuilder<LinearGradient>(
      future: getGradientFromImage(imageFile),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: screendim.height * 0.8,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.grey,
            ),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            height: screendim.height * 0.8,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(child: Text("Error loading gradient")),
          );
        } else {
          return Container(
            height: screendim.height * 0.8,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: snapshot.data,
            ),
          );
        }
      },
    );
  }
}
