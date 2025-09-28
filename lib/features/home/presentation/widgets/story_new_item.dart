import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/features/home/data/models/storymodels/story_user.dart'
    show StoryUser;
import 'package:chatbox/features/home/presentation/screens/storyviewer.dart';
import 'package:flutter/material.dart';

class StoryNewItem extends StatelessWidget {
  final StoryUser storyUser;
  final bool hasNewStory;
  bool isViewed;
  final List<StoryUser> users;
  final int currentIndex;

  StoryNewItem({
    super.key,
    required this.storyUser,
    this.hasNewStory = true,
    this.isViewed = false,
    required this.users,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isViewed = true;
        print(isViewed);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryViewer(
              users: users,
              initialUserIndex: currentIndex,

              onClose: () {
                print('Story viewer closed');
              },
            ),
          ),
        );
      },
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
                  storyUser.profileImage,
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
              storyUser.username,
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
