import 'package:chatbox/features/home/data/models/storymodels/story.dart';

class User {
  final String id;
  final String username;
  final String profileImage; // Could be a URL or local path
  final List<Story> stories;
  final String bio;
  final List<String> friends; // List of friend IDs
  final DateTime? lastSeen; // Last active time
  final bool onlineStatus; // Current online status
  final List<String> chatRooms; // List of chat room IDs

  User({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.stories,
    this.bio = '',
    this.friends = const [],
    this.lastSeen,
    this.onlineStatus = false,
    this.chatRooms = const [],
  });

  static final List<Story> myStatus = [];
  static final List<User> storyUser = [
    User(
      id: '0',
      username: 'Abdelrahman Ghareeb',
      profileImage: 'assets/images/model1.png',
      stories: [],
      friends: ['1', '2'],
      lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
      onlineStatus: false,
    ),
    User(
      id: '1',
      username: 'john_doe',
      profileImage: 'assets/images/model1.png',
      stories: [
        Story(
          id: '1',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          expiresAt: DateTime.now().add(const Duration(hours: 22)),
        ),
        Story(
          id: '2',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
          expiresAt: DateTime.now().add(const Duration(hours: 23)),
        ),
      ],
      friends: ['0', '2'],
      lastSeen: DateTime.now(),
      onlineStatus: true,
    ),
    // Add more unique users with unique IDs and usernames
    User(
      id: '2',
      username: 'jane_smith',
      profileImage: 'assets/images/model1.png',
      stories: [
        Story(
          id: '3',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          expiresAt: DateTime.now().add(const Duration(hours: 23, minutes: 30)),
        ),
      ],
      friends: ['0', '1'],
      lastSeen: DateTime.now().subtract(const Duration(minutes: 15)),
      onlineStatus: false,
    ),
  ];
}
