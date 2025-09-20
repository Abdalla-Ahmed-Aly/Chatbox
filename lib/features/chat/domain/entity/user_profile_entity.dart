import 'package:chatbox/features/profile/data/model/profile_pic.dart';
import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String username;
  final String email;
  final String address;
  final String phoneNumber;
  final ProfilePicture profilePicture;
  final String bio;
  final String status;

 const UserProfileEntity({
    required this.username,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.profilePicture,
    required this.bio,
    required this.status,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [username];
}
