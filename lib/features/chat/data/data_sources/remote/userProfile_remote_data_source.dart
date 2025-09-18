import 'package:chatbox/features/chat/data/model/user_profile_response/user_profile_response.dart';
import 'package:chatbox/features/chat/domain/use_cases/getUserProfile.dart';

abstract class UserprofileRemoteDataSource {
  Future<UserProfileResponse> getUserProfile(Params params);
}
