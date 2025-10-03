import 'package:chatbox/features/home/data/models/storymodels/post_story_response.dart';

abstract class UploadStoryState {}

class UploadStoryInitial extends UploadStoryState {}

class UploadStoryLoading extends UploadStoryState {}

class UploadStorySuccess extends UploadStoryState {
  final UploadStoryResponse response;
  UploadStorySuccess(this.response);
}

class UploadStoryFailure extends UploadStoryState {
  final String error;
  UploadStoryFailure(this.error);
}
