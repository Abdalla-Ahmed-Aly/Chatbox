import 'package:chatbox/features/home/data/models/storymodels/user.dart';
import 'package:chatbox/features/home/presentation/widgets/story_new_item.dart';
import 'package:chatbox/features/home/presentation/widgets/mystatuswid.dart';
import 'package:flutter/material.dart';

class StoryDisplay extends StatelessWidget {
  const StoryDisplay({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.15,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: User.storyUser.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: index != 0
                ? StoryNewItem(
                    storyUser: User.storyUser[index],
                    users: User.storyUser,
                    currentIndex: index,
                  )
                : MyStatus(
                    pageController: pageController,
                    username: 'My Status',
                    hasNewStory: User.storyUser[0].stories.isNotEmpty,
                  ),
          );
        },
      ),
    );
  }
}
