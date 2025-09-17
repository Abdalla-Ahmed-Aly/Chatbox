import 'package:chatbox/features/updateProfile/data/model/update_profile_request.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_response.dart';

abstract class UpdateprofileRemoteDataSources {
  Future<UpdateProfileResponse> updateProfile(UpdateProfileRequest request);
}