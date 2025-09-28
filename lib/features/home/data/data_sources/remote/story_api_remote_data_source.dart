import 'package:chatbox/core/constants/api_constant/api_constant.dart';
import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/features/home/data/data_sources/remote/story_remote_data_source.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_request.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StoryRemoteDataSource)
class StoryApiRemoteDataSource implements StoryRemoteDataSource {
  Dio dio;
  StoryApiRemoteDataSource(this.dio);

  @override
  Future<UploadStoryResponse> uploadStory(UploadStoryRequest request) async {
    try {
      final formData = await request.toFormData();

      final response = await dio.post(APIConstant.uploadStory, data: formData);
      print('dio request succeeded');

      return UploadStoryResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data["message"].toString();
        print('fuck you');
      }
      throw RemoteException(
        message ?? "An error occurred while uploading your story.",
      );
    }
  }
}
