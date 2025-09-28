class Story {
  final String id;
  final String userId; // Add userId to identify story owner
  final String mediaUrl;
  final MediaType mediaType;
  final DateTime createdAt;
  final Duration duration;
  final bool isLiked;
  final int viewCount; // Change from List<String> to int for efficiency
  final bool isViewedByCurrentUser; // Track if current user viewed it
  final String? caption;
  final List<String>? tags;
  final DateTime expiresAt; // Make required, not nullable

  Story({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.mediaType,
    required this.createdAt,
    required this.expiresAt,
    this.duration = const Duration(seconds: 5),
    this.isLiked = false,
    this.viewCount = 0,
    this.isViewedByCurrentUser = false,
    this.caption,
    this.tags,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  // Factory constructor for API response
  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      userId: json['userId'],
      mediaUrl: json['mediaUrl'],
      mediaType: MediaType.values.byName(json['mediaType']),
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: DateTime.parse(json['expiresAt']),
      duration: Duration(seconds: json['duration'] ?? 5),
      isLiked: json['isLiked'] ?? false,
      viewCount: json['viewCount'] ?? 0,
      isViewedByCurrentUser: json['isViewedByCurrentUser'] ?? false,
      caption: json['caption'],
      tags: json['tags']?.cast<String>(),
    );
  }

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType.name,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'duration': duration.inSeconds,
      'isLiked': isLiked,
      'viewCount': viewCount,
      'isViewedByCurrentUser': isViewedByCurrentUser,
      'caption': caption,
      'tags': tags,
    };
  }

  // Copy with method for state updates
  Story copyWith({
    String? id,
    String? userId,
    String? mediaUrl,
    MediaType? mediaType,
    DateTime? createdAt,
    DateTime? expiresAt,
    Duration? duration,
    bool? isLiked,
    int? viewCount,
    bool? isViewedByCurrentUser,
    String? caption,
    List<String>? tags,
  }) {
    return Story(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      duration: duration ?? this.duration,
      isLiked: isLiked ?? this.isLiked,
      viewCount: viewCount ?? this.viewCount,
      isViewedByCurrentUser:
          isViewedByCurrentUser ?? this.isViewedByCurrentUser,
      caption: caption ?? this.caption,
      tags: tags ?? this.tags,
    );
  }
}

enum MediaType {
  image,
  video;

  // Helper method for API compatibility
  static MediaType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return MediaType.image;
      case 'video':
        return MediaType.video;
      default:
        throw ArgumentError('Unknown media type: $type');
    }
  }
}
