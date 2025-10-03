import 'package:chatbox/features/home/data/models/storymodels/post_story_request.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_response.dart';

abstract class StoryRemoteDataSource {
  Future<UploadStoryResponse> uploadStory(UploadStoryRequest request);
  Future<Map<String, dynamic>> getAllStories();
}
