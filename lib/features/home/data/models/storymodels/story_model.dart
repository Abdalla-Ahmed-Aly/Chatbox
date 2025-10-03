import 'package:chatbox/features/home/domain/entity/story_entity.dart';

class StoryModel extends StoryEntity {
  const StoryModel({
    required super.id,
    required super.userId,
    required super.mediaUrl,
    required super.mediaType,
    required super.createdAt,
    required super.expiresAt,
    super.duration,
    super.viewCount,
    super.isViewedByCurrentUser,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    final mediaType = json['media']?['type'] as String? ?? 'image';
    final isVideo = mediaType.toLowerCase() == 'video';

    return StoryModel(
      id: json['_id'] as String,
      userId: json['user']['_id'] as String,
      mediaUrl: json['media']['secure_url'] as String,
      mediaType: isVideo ? StoryMediaType.video : StoryMediaType.image,
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: DateTime.parse(json['expiresAt']),
      duration: isVideo
          ? const Duration(seconds: 15)
          : const Duration(seconds: 5),
      viewCount: (json['viewedBy'] as List?)?.length ?? 0,
      isViewedByCurrentUser: false,
    );
  }

  static Map<String, String> extractUserInfo(Map<String, dynamic> json) {
    return {
      'userId': json['user']['_id'] as String,
      'username': json['user']['username'] as String,
      'profileImage': json['user']['profilePic']['secure_url'] as String,
    };
  }

  factory StoryModel.fromEntity(StoryEntity entity) {
    return StoryModel(
      id: entity.id,
      userId: entity.userId,
      mediaUrl: entity.mediaUrl,
      mediaType: entity.mediaType,
      createdAt: entity.createdAt,
      expiresAt: entity.expiresAt,
      duration: entity.duration,
      viewCount: entity.viewCount,
      isViewedByCurrentUser: entity.isViewedByCurrentUser,
    );
  }

  StoryEntity toEntity() {
    return StoryEntity(
      id: id,
      userId: userId,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
      createdAt: createdAt,
      expiresAt: expiresAt,
      duration: duration,
      viewCount: viewCount,
      isViewedByCurrentUser: isViewedByCurrentUser,
    );
  }
}
