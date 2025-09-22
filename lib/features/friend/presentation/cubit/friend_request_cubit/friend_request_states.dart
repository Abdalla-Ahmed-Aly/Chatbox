import '../../../domain/entity/friend_request_entity.dart';

abstract class FriendRequestStates{}

class FriendRequestInitial extends FriendRequestStates{}

class FriendRequestLoading extends FriendRequestStates{}

class FriendRequestSuccess extends FriendRequestStates{
  List<FriendRequestEntity> friends;
  FriendRequestSuccess({required this.friends});

}

class FriendRequestError extends FriendRequestStates {
  String error;

  FriendRequestError({required this.error});
}