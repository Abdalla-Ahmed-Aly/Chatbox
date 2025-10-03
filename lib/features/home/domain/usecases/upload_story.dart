import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_request.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_response.dart';
import 'package:chatbox/features/home/domain/repository/story_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UploadStory {
  final StoryRepository storyRepository;
  const UploadStory(this.storyRepository);
  Future<Either<Failure, UploadStoryResponse>> call(
    UploadStoryRequest request,
  ) {
    print('response is getting');
    return storyRepository.uploadStory(request);
  }
}
