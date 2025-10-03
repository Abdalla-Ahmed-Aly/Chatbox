import 'package:chatbox/features/home/domain/usecases/get_all_stories_usecases.dart';
import 'package:chatbox/features/home/presentation/cubit/get_all_stories/get_stories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryCubit extends Cubit<StoryState> {
  final GetAllStoriesUseCase getAllStoriesUseCase;

  StoryCubit(this.getAllStoriesUseCase) : super(StoryInitial());

  Future<void> fetchAllStories() async {
    emit(StoryLoading());

    final result = await getAllStoriesUseCase();

    result.fold((failure) => emit(StoryError(failure.message)), (storyUsers) {
      if (storyUsers.isEmpty) {
        emit(StoryEmpty());
      } else {
        emit(StoryLoaded(storyUsers));
      }
    });
  }

  Future<void> refreshStories() async {
    final result = await getAllStoriesUseCase();

    result.fold((failure) => emit(StoryError(failure.message)), (storyUsers) {
      if (storyUsers.isEmpty) {
        emit(StoryEmpty());
      } else {
        emit(StoryLoaded(storyUsers));
      }
    });
  }

  void retry() {
    fetchAllStories();
  }
}
