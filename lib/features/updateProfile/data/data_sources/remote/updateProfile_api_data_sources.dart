import 'package:chatbox/core/constants/api_constant/api_constant.dart';
import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/features/updateProfile/data/data_sources/remote/updateProfile_remote_data_sources.dart';
import 'package:chatbox/features/updateProfile/data/model/photoRequest.dart';
import 'package:chatbox/features/updateProfile/data/model/photo_response/photo_response.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_request.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UpdateprofileRemoteDataSources)
class UpdateprofileApiDataSources extends UpdateprofileRemoteDataSources {
  Dio dio;
  UpdateprofileApiDataSources({required this.dio});
  @override
  Future<UpdateProfileResponse> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      final response = await dio.patch(
        APIConstant.updateProfile,
        data: request.toJson(),
      );
      return UpdateProfileResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"].toString();
      }
      throw RemoteException(
        message ?? "An error occurred while update user profile.",
      );
    }
  }

  @override
  Future<PhotoResponse> updateProfilePhoto(PhotoRequest request) async {
    try {
      final formData = await request.toFormData();

      final response = await dio.patch(
        APIConstant.updateProfilePhoto,
        data: formData,
      );

      return PhotoResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"].toString();
      }
      throw RemoteException(
        message ?? "An error occurred while updating user profile photo.",
      );
    }
  }
}
