import '../../../domain/entity/friend_entity.dart';

abstract class FriendStats {}

class FriendStatsInitial extends FriendStats {}

class FriendStatsLoading extends FriendStats {}

class FriendStatsSuccess extends FriendStats {
  final List<FriendEntity> friends;
  FriendStatsSuccess({required this.friends});
}

class FriendStatsError extends FriendStats {
  final String message;

  FriendStatsError({required this.message});
}