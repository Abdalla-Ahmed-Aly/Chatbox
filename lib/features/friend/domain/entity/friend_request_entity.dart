import 'package:equatable/equatable.dart';

class FriendRequestEntity extends Equatable {
  final String profilePic;
  final String bio;
  final String username;
 const FriendRequestEntity({required this.profilePic,required this.bio,required this.username});

  @override
  List<Object?> get props => [username];




}