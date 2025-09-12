class Story {
  final String id;
  final String mediaUrl; // Could be a URL or local path
  final MediaType mediaType;
  final DateTime createdAt;
  final Duration duration;
  final bool isLiked;
  final List<String> viewedBy; // List of user IDs who viewed the story
  final String? caption; // Optional caption for the story
  final List<String>? tags; // Optional list of tagged user IDs
  final DateTime? expiresAt; // When the story expires

  Story({
    required this.id,
    required this.mediaUrl,
    required this.mediaType,
    required this.createdAt,
    this.duration = const Duration(seconds: 5),
    this.isLiked = false,
    this.viewedBy = const [],
    this.caption,
    this.tags,
    this.expiresAt,
  });

  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
}

enum MediaType { image, video }
