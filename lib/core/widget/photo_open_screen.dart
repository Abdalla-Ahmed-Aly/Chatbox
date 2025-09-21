import 'package:flutter/material.dart';

class PhotoOpenScreen extends StatelessWidget {
  final String imageUrl;

  const PhotoOpenScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 0.8,
            maxScale: 3.0,
            child: imageUrl.isNotEmpty
                ? Image.network(imageUrl)
                : const Icon(Icons.person, color: Colors.white, size: 100),
          ),
        ),
      ),
    );
  }
}
