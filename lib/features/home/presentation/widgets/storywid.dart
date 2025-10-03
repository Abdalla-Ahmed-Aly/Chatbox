import 'package:chatbox/features/home/data/models/storymodels/story_user.dart';
import 'package:chatbox/features/home/presentation/widgets/story_new_item.dart';
import 'package:chatbox/features/home/presentation/widgets/mystatuswid.dart';
import 'package:flutter/material.dart';

class StoryDisplay extends StatelessWidget {
  StoryDisplay({
    super.key,
    required this.pageController,
    required this.users,
    this.isloading = false,
  });
  final PageController pageController;
  final List<StoryUser> users;
  bool isloading;

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
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.02,
                ),
                child: SizedBox(
                  width: storySize,
                  child: index != 0
                      ? StoryNewItem(
                          storyUser: users[index],
                          users: users,
                          currentIndex: index,
                        )
                      : MyStatus(
                          pageController: pageController,
                          storyUsers: users,
                          isUploading: isloading,
                          image: 'assets/images/model1.png',
                          username: 'My Status',
                          hasNewStory: users[index].stories.isNotEmpty,
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
