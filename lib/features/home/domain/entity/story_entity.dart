class StoryEntity {
  final String id;
  final String userId;
  final String mediaUrl;
  final StoryMediaType mediaType;
  final DateTime createdAt;
  final DateTime expiresAt;
  final Duration duration;
  final int viewCount;
  final bool isViewedByCurrentUser;

  const StoryEntity({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.mediaType,
    required this.createdAt,
    required this.expiresAt,
    this.duration = const Duration(seconds: 5),
    this.viewCount = 0,
    this.isViewedByCurrentUser = false,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

enum StoryMediaType { image, video }
