import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_request.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_response.dart';
import 'package:chatbox/features/home/domain/entity/story_user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class StoryRepository {
  Future<Either<Failure, UploadStoryResponse>> uploadStory(
    UploadStoryRequest request,
  );
  Future<Either<Failure, List<StoryUserEntity>>> getAllStories();
}
