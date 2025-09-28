import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/home/data/data_sources/remote/story_remote_data_source.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_request.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_response.dart';
import 'package:chatbox/features/home/domain/repository/story_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StoryRepository)
class StoryRepoImpl implements StoryRepository {
  final StoryRemoteDataSource storyRemoteDataSource;
  const StoryRepoImpl(this.storyRemoteDataSource);

  @override
  Future<Either<Failure, UploadStoryResponse>> uploadStory(
    UploadStoryRequest request,
  ) async {
    try {
      final response = await storyRemoteDataSource.uploadStory(request);
      print('uploadStory response: $response');
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message.toString()));
    }
  }
}
