abstract class HandelFriendRequestStates{}

class HandelFriendRequestInitial extends HandelFriendRequestStates{}
class HandelFriendRequestLoading extends HandelFriendRequestStates{}
class HandelFriendRequestSuccess extends HandelFriendRequestStates{
  final String message;
  HandelFriendRequestSuccess({required this.message});
}
class HandelFriendRequestError extends HandelFriendRequestStates {
  final String error;

  HandelFriendRequestError({required this.error});
}