import 'package:chatbox/features/home/domain/entity/story_entity.dart';

class StoryUserEntity {
  final String userId;
  final String username;
  final String profileImage;
  final List<StoryEntity> stories;
  final bool hasUnviewedStories;
  final bool isCurrentUser;

  const StoryUserEntity({
    required this.userId,
    required this.username,
    required this.profileImage,
    required this.stories,
    this.hasUnviewedStories = false,
    this.isCurrentUser = false,
  });

  bool get hasStories => stories.isNotEmpty;

  List<StoryEntity> get activeStories =>
      stories.where((story) => !story.isExpired).toList();
}
