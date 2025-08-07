import 'package:chatbox/featrures/home/presentation/widgets/storyitem.dart';
import 'package:flutter/material.dart';

class StoryDisplay extends StatelessWidget {
  const StoryDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.15,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StoryItem(name: 'Ghareeb', path: 'assets/image/model1.png'),
          );
        },
      ),
    );
  }
}
