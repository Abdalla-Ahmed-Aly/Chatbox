class Story {
  final String id;
  final String mediaUrl;
  final MediaType mediaType;
  final DateTime createdAt;
  final Duration duration;
  final bool isLiked;

  Story({
    required this.id,
    required this.mediaUrl,
    required this.mediaType,
    required this.createdAt,
    this.duration = const Duration(seconds: 5),
    this.isLiked = false,
  });
}

enum MediaType { image, video }
