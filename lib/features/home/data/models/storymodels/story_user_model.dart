import 'package:chatbox/features/home/data/models/storymodels/story_model.dart';
import 'package:chatbox/features/home/domain/entity/story_user_entity.dart';

class StoryUserModel extends StoryUserEntity {
  const StoryUserModel({
    required super.userId,
    required super.username,
    required super.profileImage,
    required super.stories,
  });

  factory StoryUserModel.fromJson(Map<String, dynamic> json) {
    return StoryUserModel(
      userId: json['userId'] as String,
      username: json['username'] as String,
      profileImage: json['profileImage'] as String,
      stories: (json['stories'] as List<dynamic>)
          .map((story) => StoryModel.fromJson(story))
          .toList(),
    );
  }

  factory StoryUserModel.fromEntity(StoryUserEntity entity) {
    return StoryUserModel(
      userId: entity.userId,
      username: entity.username,
      profileImage: entity.profileImage,
      stories: entity.stories,
    );
  }

  StoryUserEntity toEntity() {
    return StoryUserEntity(
      userId: userId,
      username: username,
      profileImage: profileImage,
      stories: stories,
    );
  }
}
