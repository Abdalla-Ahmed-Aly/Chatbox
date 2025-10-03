import 'package:chatbox/features/home/data/models/storymodels/post_story_request.dart';
import 'package:chatbox/features/home/domain/usecases/upload_story.dart';
import 'package:chatbox/features/home/presentation/cubit/upload_story/upload_story_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadStoryCubit extends Cubit<UploadStoryState> {
  final UploadStory _uploadStory;
  UploadStoryCubit(this._uploadStory) : super(UploadStoryInitial());

  Future<void> uploadStory(UploadStoryRequest request) async {
    if (isClosed) return;
    emit(UploadStoryLoading());
    final result = await _uploadStory(request);

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(UploadStoryFailure(failure.message));
        }
      },
      (success) {
        if (!isClosed) {
          emit(UploadStorySuccess(success));
        }
      },
    );
  }
}
