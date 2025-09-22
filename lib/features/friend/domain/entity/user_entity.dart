import 'package:equatable/equatable.dart';

class UserSearch extends Equatable {
  final String profilePic;
  final String bio;
  final String username;
  final String status;
  const UserSearch({required this.username,required this.bio,required this.profilePic,required this.status});




  @override
  // TODO: implement props
  List<Object?> get props =>[username];



}