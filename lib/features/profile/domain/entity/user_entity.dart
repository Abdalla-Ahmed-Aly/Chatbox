import 'package:chatbox/features/profile/domain/entity/sup_entity/photo.dart';

class UserEntity {
  final String username;
  final String email;
  final String id;
  final String phoneNumber;
  final String bio;
  final String address;
  ProfilePictureEntity profilePicture;

  UserEntity({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.bio,
    required this.address,
    required this.profilePicture,
    required this.id,
  });
}
