import 'package:chatbox/core/constants/api_constant/api_constant.dart';
import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/features/chat/data/data_sources/remote/userProfile_remote_data_source.dart';
import 'package:chatbox/features/chat/data/model/user_profile_response/user_profile_response.dart';
import 'package:chatbox/features/chat/domain/use_cases/getUserProfile.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserprofileRemoteDataSource)
class UserprofileApiDataSource implements UserprofileRemoteDataSource {
  final Dio _dio;
  UserprofileApiDataSource(this._dio);
  @override
  Future<UserProfileResponse> getUserProfile(Params params) async {
    try {
      final response = await _dio.get(
        "${APIConstant.userProfileEndpoint}/${params.username}",
      );
      return UserProfileResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"].toString();
      }
      throw RemoteException(
        message ?? "An error occurred while fetching user profile.",
      );
    }
  }
}
