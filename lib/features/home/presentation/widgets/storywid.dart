import 'package:chatbox/features/home/data/models/storymodels/story_user.dart';
import 'package:chatbox/features/home/presentation/widgets/story_new_item.dart';
import 'package:chatbox/features/home/presentation/widgets/mystatuswid.dart';
import 'package:flutter/material.dart';

class StoryDisplay extends StatelessWidget {
  const StoryDisplay({super.key, required this.pageController});
  final PageController pageController;

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
            itemCount: StoryUser.storyUser.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.02,
                ),
                child: SizedBox(
                  width: storySize,
                  child: index != 0
                      ? StoryNewItem(
                          storyUser: StoryUser.storyUser[index],
                          users: StoryUser.storyUser,
                          currentIndex: index,
                        )
                      : MyStatus(
                          pageController: pageController,
                          image: 'assets/images/model1.png',
                          username: 'My Status',
                          hasNewStory:
                              StoryUser.storyUser[0].stories.isNotEmpty,
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
