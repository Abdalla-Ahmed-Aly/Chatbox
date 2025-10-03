import 'package:chatbox/features/home/data/models/storymodels/story.dart';

class StoryUser {
  final String userId;
  final String username;
  final String profileImage;
  final List<Story> stories;
  final int totalStoriesCount;
  final DateTime? lastStoryTimestamp;
  final bool hasUnviewedStories;
  final bool isCurrentUser;

  StoryUser({
    required this.userId,
    required this.username,
    required this.profileImage,
    required this.stories,
    required this.totalStoriesCount,
    this.lastStoryTimestamp,
    this.hasUnviewedStories = false,
    this.isCurrentUser = false,
  });

  factory StoryUser.fromJson(Map<String, dynamic> json) {
    List<Story> storiesList = [];
    if (json['stories'] != null) {
      storiesList = (json['stories'] as List)
          .map((storyJson) => Story.fromJson(storyJson))
          .toList();
    }

    return StoryUser(
      userId: json['userId'],
      username: json['username'],
      profileImage: json['profileImage'],
      stories: storiesList,
      totalStoriesCount: json['totalStoriesCount'] ?? storiesList.length,
      lastStoryTimestamp: json['lastStoryTimestamp'] != null
          ? DateTime.parse(json['lastStoryTimestamp'])
          : null,
      hasUnviewedStories: json['hasUnviewedStories'] ?? false,
      isCurrentUser: json['isCurrentUser'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'profileImage': profileImage,
      'stories': stories.map((story) => story.toJson()).toList(),
      'totalStoriesCount': totalStoriesCount,
      'lastStoryTimestamp': lastStoryTimestamp?.toIso8601String(),
      'hasUnviewedStories': hasUnviewedStories,
      'isCurrentUser': isCurrentUser,
    };
  }

  bool get hasStories => stories.isNotEmpty;

  List<Story> get activeStories =>
      stories.where((story) => !story.isExpired).toList();

  StoryUser copyWith({
    String? userId,
    String? username,
    String? profileImage,
    List<Story>? stories,
    int? totalStoriesCount,
    DateTime? lastStoryTimestamp,
    bool? hasUnviewedStories,
    bool? isCurrentUser,
  }) {
    return StoryUser(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      profileImage: profileImage ?? this.profileImage,
      stories: stories ?? this.stories,
      totalStoriesCount: totalStoriesCount ?? this.totalStoriesCount,
      lastStoryTimestamp: lastStoryTimestamp ?? this.lastStoryTimestamp,
      hasUnviewedStories: hasUnviewedStories ?? this.hasUnviewedStories,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }

  static final List<StoryUser> storyUser = [
    StoryUser(
      userId: '0',
      username: 'Abdelrahman Ghareeb',
      profileImage: 'assets/images/model1.png',
      stories: [],
      totalStoriesCount: 0,
    ),
    StoryUser(
      userId: '1',
      username: 'john_doe',
      profileImage: 'assets/images/model1.png',
      totalStoriesCount: 2,
      stories: [
        Story(
          id: '1',
          userId: '1',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          expiresAt: DateTime.now().add(const Duration(hours: 22)),
        ),
        Story(
          id: '2',
          userId: '1',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
          expiresAt: DateTime.now().add(const Duration(hours: 23)),
        ),
      ],
    ),
    StoryUser(
      userId: '2',
      username: 'jane_smith',
      profileImage: 'assets/images/model1.png',
      totalStoriesCount: 1,
      stories: [
        Story(
          id: '3',
          userId: '2',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          expiresAt: DateTime.now().add(const Duration(hours: 23, minutes: 30)),
        ),
      ],
    ),
  ];
}
