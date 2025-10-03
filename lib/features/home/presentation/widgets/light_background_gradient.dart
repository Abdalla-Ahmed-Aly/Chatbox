import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:math';
import 'dart:io';

class ColorExtractorWidget extends StatefulWidget {
  final String imagePath;
  final int colorCount;
  final Widget child;

  const ColorExtractorWidget({
    super.key,
    required this.imagePath,
    this.colorCount = 5,
    required this.child,
  });

  @override
  State<ColorExtractorWidget> createState() => _ColorExtractorWidgetState();
}

class _ColorExtractorWidgetState extends State<ColorExtractorWidget> {
  List<Color> _dominantColors = [];
  bool _isProcessing = false;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImageAndExtractColors();
  }

  @override
  void didUpdateWidget(ColorExtractorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {
      _loadImageAndExtractColors();
    }
  }

  Future<void> _loadImageAndExtractColors() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      // Load image from path and convert to Uint8List
      final File imageFile = File(widget.imagePath);
      final Uint8List imageBytes = await imageFile.readAsBytes();

      setState(() {
        _imageBytes = imageBytes;
      });

      final colors = await _extractDominantColors(imageBytes);
      if (mounted) {
        setState(() {
          _dominantColors = colors;
          _isProcessing = false;
        });
      }
    } catch (e) {
      print('Error loading image or extracting colors: $e');
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<List<Color>> _extractDominantColors(Uint8List imageBytes) async {
    try {
      // Decode the image
      final img.Image? image = img.decodeImage(imageBytes);
      if (image == null) return [];

      // Resize image for faster processing
      final img.Image resized = img.copyResize(image, width: 100, height: 100);

      // Count colors with proper RGB extraction
      Map<String, int> colorCount = {};

      for (int y = 0; y < resized.height; y++) {
        for (int x = 0; x < resized.width; x++) {
          final pixel = resized.getPixel(x, y);

          // Get RGB values correctly - pixel values are already 0-255 range
          int r, g, b;

          if (pixel.r > 1.0 || pixel.g > 1.0 || pixel.b > 1.0) {
            // Already in 0-255 range
            r = pixel.r.round();
            g = pixel.g.round();
            b = pixel.b.round();
          } else {
            // In 0-1 range, convert to 0-255
            r = (pixel.r * 255).round();
            g = (pixel.g * 255).round();
            b = (pixel.b * 255).round();
          }

          // Clamp values to valid range
          r = r.clamp(0, 255);
          g = g.clamp(0, 255);
          b = b.clamp(0, 255);

          // Quantize colors to reduce similar shades (group similar colors)
          r = (r ~/ 16) * 16; // Reduce to 16 steps
          g = (g ~/ 16) * 16;
          b = (b ~/ 16) * 16;

          final colorKey = '$r,$g,$b';
          colorCount[colorKey] = (colorCount[colorKey] ?? 0) + 1;
        }
      }

      // Sort colors by frequency
      final sortedColors = colorCount.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      // Extract top colors
      List<Color> dominantColors = [];

      for (int i = 0; i < min(widget.colorCount, sortedColors.length); i++) {
        final rgb = sortedColors[i].key.split(',');
        final r = int.parse(rgb[0]);
        final g = int.parse(rgb[1]);
        final b = int.parse(rgb[2]);

        final color = Color.fromARGB(255, r, g, b);

        // Only add if it's significantly different from existing colors
        bool isDifferent = true;
        for (final existingColor in dominantColors) {
          final distance = sqrt(
            pow(color.red - existingColor.red, 2) +
                pow(color.green - existingColor.green, 2) +
                pow(color.blue - existingColor.blue, 2),
          );
          if (distance < 50) {
            // Colors too similar
            isDifferent = false;
            break;
          }
        }

        if (isDifferent) {
          dominantColors.add(color);
        }
      }

      // Debug: Print extracted colors
      print('Extracted colors:');
      for (final color in dominantColors) {
        print('RGB(${color.red}, ${color.green}, ${color.blue})');
      }

      return dominantColors;
    } catch (e) {
      print('Error extracting colors: $e');
      return [];
    }
  }

  LinearGradient _createGradient() {
    if (_dominantColors.isEmpty) {
      return const LinearGradient(
        colors: [Colors.grey, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return LinearGradient(
      colors: _dominantColors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: _generateStops(_dominantColors.length),
    );
  }

  List<double> _generateStops(int colorCount) {
    if (colorCount <= 1) return [1.0];

    List<double> stops = [];
    for (int i = 0; i < colorCount; i++) {
      stops.add(i / (colorCount - 1));
    }
    return stops;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: _createGradient(),
      ),
      clipBehavior: Clip.antiAlias,
      child: _isProcessing
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : widget.child,
    );
  }
}
