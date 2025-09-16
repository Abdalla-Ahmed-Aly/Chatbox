import 'package:chatbox/features/profile/data/model/media_shared.dart';
import 'package:chatbox/features/profile/data/model/profile_pic.dart';
import 'package:chatbox/features/profile/domain/entity/user_entity.dart';

class User extends UserEntity {
  final MediaShared? mediaShared;
  final String? id;

  final List<dynamic>? friends;
  final List<dynamic>? groups;
  final List<dynamic>? stories;
  final String? status;
  final bool? isLoggedIn;
  final bool? isActivated;
  final bool? isConfirmed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? firstLetter;

   User({
    this.mediaShared,
    this.id,
    this.friends,
    this.groups,
    this.stories,
    this.status,
    this.isLoggedIn,
    this.isActivated,
    this.isConfirmed,
    this.createdAt,
    this.updatedAt,
    this.firstLetter,
    required super.username,
    required super.email,
    required super.phoneNumber,
    required super.bio,
    required super.address,
    required super.profilePicture,
  });

factory User.fromJson(Map<String, dynamic> json) => User(
      mediaShared: json['mediaShared'] == null
          ? null
          : MediaShared.fromJson(json['mediaShared']),
      id: json['_id'] as String?,
      friends: json['friends'] as List<dynamic>?,
      groups: json['groups'] as List<dynamic>?,
      stories: json['stories'] as List<dynamic>?,
      status: json['status'] as String?,
      isLoggedIn: json['isLoggedIn'] as bool?,
      isActivated: json['isActivated'] as bool?,
      isConfirmed: json['isConfirmed'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt']),
      firstLetter: json['firstLetter'] as String?,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      address: json['address'] as String? ?? '',
      profilePicture: json['profilePic'] == null
          ? ProfilePicture(secureUrl: '', publicId: '')
          : ProfilePicture.fromJson(json['profilePic']),
    );
 }
