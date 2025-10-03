import 'package:chatbox/features/home/data/models/storymodels/story.dart';
import 'package:chatbox/features/home/data/models/storymodels/story_user.dart';
import 'package:chatbox/features/home/domain/entity/story_entity.dart';
import 'package:chatbox/features/home/domain/entity/story_user_entity.dart';

class StoryMapper {
  static Story toStoryModel(StoryEntity entity) {
    return Story(
      id: entity.id,
      userId: entity.userId,
      mediaUrl: entity.mediaUrl,
      mediaType: entity.mediaType == StoryMediaType.video
          ? MediaType.video
          : MediaType.image,
      createdAt: entity.createdAt,
      expiresAt: entity.expiresAt,
      duration: entity.duration,
      viewCount: entity.viewCount,
      isViewedByCurrentUser: entity.isViewedByCurrentUser,
    );
  }

  static StoryUser toStoryUserModel(StoryUserEntity entity) {
    return StoryUser(
      userId: entity.userId,
      username: entity.username,
      profileImage: entity.profileImage,
      stories: entity.stories.map((story) => toStoryModel(story)).toList(),
      totalStoriesCount: entity.stories.length,
      hasUnviewedStories: entity.hasUnviewedStories,
      isCurrentUser: entity.isCurrentUser,
    );
  }

  static List<StoryUser> toStoryUserModelList(List<StoryUserEntity> entities) {
    return entities.map((entity) => toStoryUserModel(entity)).toList();
  }
}
