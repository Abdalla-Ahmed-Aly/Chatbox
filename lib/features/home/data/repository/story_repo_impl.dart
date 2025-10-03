import 'package:chatbox/core/error/exceptions.dart';
import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/home/data/data_sources/remote/story_remote_data_source.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_request.dart';
import 'package:chatbox/features/home/data/models/storymodels/post_story_response.dart';
import 'package:chatbox/features/home/data/models/storymodels/story_model.dart';
import 'package:chatbox/features/home/domain/entity/story_entity.dart';
import 'package:chatbox/features/home/domain/entity/story_user_entity.dart';
import 'package:chatbox/features/home/domain/repository/story_repo.dart';
import 'package:chatbox/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StoryRepository)
class StoryRepoImpl implements StoryRepository {
  final StoryRemoteDataSource storyRemoteDataSource;
  final ProfileCubit profileCubit;
  const StoryRepoImpl(this.storyRemoteDataSource, this.profileCubit);

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

  @override
  Future<Either<Failure, List<StoryUserEntity>>> getAllStories() async {
    try {
      final currentUserId = profileCubit.currentUserId;
      final responseData = await storyRemoteDataSource.getAllStories();
      final List<dynamic> results = responseData['results'] ?? [];

      if (results.isEmpty) {
        return const Right([]);
      }

      final groupedStories = _groupStoriesByUser(results);

      _sortStoryUsers(groupedStories);

      return Right(groupedStories);
    } on AppException catch (exception) {
      return Left(Failure(exception.message.toString()));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  List<StoryUserEntity> _groupStoriesByUser(List<dynamic> results) {
    final currentUserId = profileCubit.currentUserId;
    Map<String, List<StoryEntity>> storiesByUser = {};
    Map<String, Map<String, String>> userInfoMap = {};

    for (var storyJson in results) {
      final userInfo = StoryModel.extractUserInfo(storyJson);
      final userId = userInfo['userId']!;

      if (!userInfoMap.containsKey(userId)) {
        userInfoMap[userId] = userInfo;
      }

      if (!storiesByUser.containsKey(userId)) {
        storiesByUser[userId] = [];
      }

      final storyModel = StoryModel.fromJson(storyJson);
      storiesByUser[userId]!.add(storyModel.toEntity());
    }

    List<StoryUserEntity> storyUsers = [];

    storiesByUser.forEach((userId, stories) {
      final userInfo = userInfoMap[userId]!;
      final isCurrentUser = userId == currentUserId;

      final hasUnviewed = stories.any((story) => !story.isViewedByCurrentUser);

      storyUsers.add(
        StoryUserEntity(
          userId: userId,
          username: userInfo['username']!,
          profileImage: userInfo['profileImage']!,
          stories: stories,
          isCurrentUser: isCurrentUser,
          hasUnviewedStories: hasUnviewed,
        ),
      );
    });

    return storyUsers;
  }

  void _sortStoryUsers(List<StoryUserEntity> users) {
    final currentUserId = profileCubit.currentUserId;
    users.sort((a, b) {
      if (currentUserId != null) {
        if (a.userId == currentUserId) return -1;
        if (b.userId == currentUserId) return 1;
      }

      if (a.stories.isNotEmpty && b.stories.isNotEmpty) {
        return b.stories.first.createdAt.compareTo(a.stories.first.createdAt);
      }

      return 0;
    });
  }
}
