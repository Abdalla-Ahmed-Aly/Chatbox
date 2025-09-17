import 'package:chatbox/features/updateProfile/data/model/photo_response/photo_response.dart';
import 'package:chatbox/features/updateProfile/domain/entity/update_profile_Entity.dart';

abstract class UpdateprofileState {}

class UpdateprofileInitial extends UpdateprofileState {}

class UpdateprofileLoading extends UpdateprofileState {}
class UpdateprofilePhotoLoading extends UpdateprofileState {}

class UpdateprofileSuccess extends UpdateprofileState {
  final UpdateProfileEntity update;
  UpdateprofileSuccess(this.update);
}
class UpdateprofilePhotoSuccess extends UpdateprofileState {
  final PhotoResponse update;
  UpdateprofilePhotoSuccess(this.update);
}

class UpdateprofileFailure extends UpdateprofileState {
  final String error;
  UpdateprofileFailure(this.error);
}
class UpdateprofilePhotoFailure extends UpdateprofileState {
  final String error;
  UpdateprofilePhotoFailure(this.error);
}
