import 'package:chatbox/features/profile/data/model/profile_pic.dart';

class UserProfileEntity {
  final String username;
  final String email;
  final String address;
  final String phoneNumber;
  final ProfilePicture profilePicture;
  final String bio;
  final String status;

  UserProfileEntity({
    required this.username,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.profilePicture,
    required this.bio,
    required this.status,
  });
}
