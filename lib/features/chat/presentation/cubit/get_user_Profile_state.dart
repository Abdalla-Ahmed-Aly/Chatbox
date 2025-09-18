import 'package:chatbox/features/chat/domain/entity/User_profile_entity.dart';

abstract class GetUserProfileState {}
class GetUserProfileInitial extends GetUserProfileState {}
class GetUserProfileLoading extends GetUserProfileState {}
class UpdateprofilePhotoLoading extends GetUserProfileState {}

class GetUserProfileSuccess extends GetUserProfileState {
  final UserProfileEntity data;
  GetUserProfileSuccess(this.data);
}
class GetUserProfileFailure extends GetUserProfileState {
  final String error;
  GetUserProfileFailure(this.error);
}
 