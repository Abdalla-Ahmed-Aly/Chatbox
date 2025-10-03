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

class GradientContainer extends StatefulWidget {
  final File imageFile;
  final Widget? child;

  const GradientContainer({super.key, required this.imageFile, this.child});

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  LinearGradient? _gradient;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _extractColors();
  }

  @override
  void didUpdateWidget(GradientContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-extract colors if the image file changes
    if (oldWidget.imageFile.path != widget.imageFile.path) {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _gradient = null;
      });
      _extractColors();
    }
  }

  Future<void> _extractColors() async {
    try {
      final gradient = await getGradientFromImage(widget.imageFile);
      if (mounted) {
        setState(() {
          _gradient = gradient;
          _isLoading = false;
          _hasError = false;
        });
      }
    } catch (e) {
      print('Error extracting gradient: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenDim = MediaQuery.of(context).size;

    // Loading state
    if (_isLoading) {
      return Container(
        height: screenDim.height * 0.8,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey.shade300,
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Extracting colors...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    // Error state
    if (_hasError) {
      return Container(
        height: screenDim.height * 0.8,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.red.shade300,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 48),
              SizedBox(height: 16),
              Text(
                "Error loading gradient",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Success state - show gradient with optional child
    return Container(
      height: screenDim.height * 0.8,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: _gradient,
      ),
      child: widget.child,
    );
  }
}
