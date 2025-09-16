import 'package:chatbox/core/constants/api_constant/api_constant.dart';
import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/features/profile/data/data_sources/remote/user_remote_data_source.dart';
import 'package:chatbox/features/profile/data/model/user_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRemoteDataSource)
class UserApiDataSource extends UserRemoteDataSource {
  final Dio _dio;
  UserApiDataSource(this._dio);

  @override
  Future<UserResponse> getUserProfile() async {
    try {
      final response = await _dio.get(APIConstant.userProfileEndpoint);
      return UserResponse.fromJson(response.data);
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
