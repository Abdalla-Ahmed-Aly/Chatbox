import 'package:chatbox/features/updateProfile/domain/entity/update_profile_Entity.dart';

abstract class UpdateprofileState {}

class UpdateprofileInitial extends UpdateprofileState {}

class UpdateprofileLoading extends UpdateprofileState {}

class UpdateprofileSuccess extends UpdateprofileState {
  final UpdateProfileEntity update;
  UpdateprofileSuccess(this.update);
}

class UpdateprofileFailure extends UpdateprofileState {
  final String error;
  UpdateprofileFailure(this.error);
}
