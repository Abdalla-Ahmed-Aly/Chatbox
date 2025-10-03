import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/home/domain/entity/story_user_entity.dart';
import 'package:chatbox/features/home/domain/repository/story_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllStoriesUseCase {
  final StoryRepository repository;

  GetAllStoriesUseCase(this.repository);

  Future<Either<Failure, List<StoryUserEntity>>> call() async {
    return await repository.getAllStories();
  }
}
