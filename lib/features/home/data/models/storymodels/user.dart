import 'package:chatbox/features/home/data/models/storymodels/story.dart';

class User {
  final String id;
  final String username;
  final String profileImage;
  final List<Story> stories;
  final String bio;

  User({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.stories,
    this.bio = '',
    // required this.friends ,
  });

  static final List<Story> myStatus = [];
  static final List<User> storyUser = [
    User(
      id: '0',
      username: 'Abdelrahman Ghareeb',
      profileImage: 'assets/images/model1.png',
      stories: [],
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
        ),
        Story(
          id: '2',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ],
    ),
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
        ),
        Story(
          id: '4',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
      ],
    ),
    User(
      id: '3',
      username: 'jane_smith',
      profileImage: 'assets/images/model1.png',
      stories: [
        Story(
          id: '5',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        Story(
          id: '6',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
      ],
    ),
    User(
      id: '4',
      username: 'jane_smith',
      profileImage: 'assets/images/model1.png',
      stories: [
        Story(
          id: '7',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        Story(
          id: '8',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
        Story(
          id: '8',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
        Story(
          id: '8',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
      ],
    ),
    User(
      id: '5',
      username: 'jane_smith',
      profileImage: 'assets/images/model1.png',
      stories: [
        Story(
          id: '9',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        Story(
          id: '10',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
      ],
    ),
    User(
      id: '6',
      username: 'jane_smith',
      profileImage: 'assets/images/model1.png',
      stories: [
        Story(
          id: '11',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        Story(
          id: '12',
          mediaUrl: 'assets/images/comic.png',
          mediaType: MediaType.image,
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
      ],
    ),
  ];
}
