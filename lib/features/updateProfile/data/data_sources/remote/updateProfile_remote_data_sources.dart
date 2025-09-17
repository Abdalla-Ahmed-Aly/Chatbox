import 'package:chatbox/features/updateProfile/data/model/photoRequest.dart';
import 'package:chatbox/features/updateProfile/data/model/photo_response/photo_response.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_request.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_response.dart';

abstract class UpdateprofileRemoteDataSources {
  Future<UpdateProfileResponse> updateProfile(UpdateProfileRequest request);
  Future<PhotoResponse> updateProfilePhoto(PhotoRequest request);
}