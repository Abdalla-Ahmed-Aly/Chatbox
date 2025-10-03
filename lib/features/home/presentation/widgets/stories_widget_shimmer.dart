import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoryShimmer extends StatelessWidget {
  const StoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final storySize = constraints.maxWidth * 0.22;
        final storyHeight = storySize * 1.3;

        return SizedBox(
          height: storyHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.02,
                ),
                child: SizedBox(
                  width: storySize,
                  child: _StoryShimmerItem(storySize: storySize),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _StoryShimmerItem extends StatelessWidget {
  final double storySize;

  const _StoryShimmerItem({required this.storySize});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 60,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
