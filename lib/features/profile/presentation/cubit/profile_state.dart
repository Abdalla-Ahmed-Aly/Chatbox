import 'package:chatbox/features/profile/domain/entity/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserEntity message;
  ProfileSuccess(this.message);
}

class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure(this.error);
}
