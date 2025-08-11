import 'package:chatbox/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class StoryNewItem extends StatelessWidget {
  final String username;
  final String image;
  final bool hasNewStory;
  final bool isViewed;
  final VoidCallback? onTap;

  const StoryNewItem({
    super.key,
    this.username = 'Ghareeb',
    this.image = 'assets/images/model1.png',
    this.hasNewStory = true,
    this.isViewed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: hasNewStory && !isViewed
                  ? const LinearGradient(
                      colors: [
                        Color(0xFFF58529),
                        Color(0xFFDD2A7B),
                        Color(0xFF8134AF),
                        Color(0xFF515BD4),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    )
                  : null,
              border: isViewed
                  ? Border.all(color: Colors.transparent, width: 4)
                  : null,
              color: !hasNewStory ? Colors.grey : null,
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.black, width: 3),
              ),
              child: ClipOval(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: 66,
                  height: 66,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 70,
            child: Text(
              username,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
