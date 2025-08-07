import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String name;
  final String path;
  final double size;
  final Color borderColor;
  final Color backgroundColor;

  const StoryItem({
    super.key,
    required this.name,
    required this.path,
    this.size = 100.0,
    this.borderColor = const Color(0xFF8B7CF6),
    this.backgroundColor = const Color(0xFF0F172A),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size - 40,
      height: size + 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size * 0.6,
            height: size * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 3.0),
            ),
            child: ClipOval(
              child: Image.asset(
                path,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(name, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
