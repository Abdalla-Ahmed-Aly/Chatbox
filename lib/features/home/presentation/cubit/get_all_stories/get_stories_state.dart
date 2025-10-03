import 'package:chatbox/features/home/domain/entity/story_user_entity.dart';

abstract class StoryState {}

class StoryInitial extends StoryState {}

class StoryLoading extends StoryState {}

class StoryLoaded extends StoryState {
  final List<StoryUserEntity> users;

  StoryLoaded(this.users);
}

class StoryEmpty extends StoryState {}

class StoryError extends StoryState {
  final String message;

  StoryError(this.message);
}
