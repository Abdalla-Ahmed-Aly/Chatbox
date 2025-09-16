import 'package:chatbox/features/profile/data/model/user_response.dart';

abstract class UserRemoteDataSource {
  Future<UserResponse> getUserProfile();
}
